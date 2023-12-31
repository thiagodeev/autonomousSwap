// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract AutonomousSwap is ERC721Holder, ERC1155Holder{
  //random number for ERC20, just to identify it
  bytes4 private constant _ERC20_ID = 0xec20ec20;
  bytes4 private constant _ERC721_ID = 0x80ac58cd;
  bytes4 private constant _ERC1155_ID = 0xd9b67a26;

  mapping (bytes32 orderId => MainOrder) private _orders;
  mapping (address user => mapping (bytes32 orderId => SubOrder)) private _orderOf;

  struct MainOrder {
    address creator;
    address partner;
    bool isActive;
  }

  struct SubOrder {
    address token;
    bytes4 interfaceID;
    uint256 tokenId; //for the case of an ERC721/ERC1155 token
    uint256 quantity;
    Status individualStatus;
  }

  enum Status {
    Pending,
    ProposalSubmited,
    TokenLocked,
    Completed,
    Canceled
  }

  event StepCompleted(bytes32 indexed orderId, address indexed who, Status indexed newStatus);

  error InvalidToken(address tokenAddress);
  error MustBeTheCreator(address caller, address creator);
  error MustBeThePartner(address caller, address creator);
  error InvalidCurrentStatus(address who, Status current, Status needed);

  error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);
  error ERC20InsufficientAllowance(address spender, uint256 allowance, uint256 needed);
  error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);
  error ERC721InsufficientApproval(address operator, uint256 tokenId);
  error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);
  error ERC1155MissingApprovalForAll(address operator, address owner);

  modifier isActive(bytes32 orderId) {
    require(_orders[orderId].isActive == true, 'This order is not active.');
    _;
  }

  //PRIVATE GETTERS
  function _getCreator(bytes32 orderId) private view returns (address) {
    return _orders[orderId].creator;
  }

  function _getPartner(bytes32 orderId) private view returns (address) {
    return _orders[orderId].partner;
  }

  function _isERC20(address account) private view returns (bool){
    try IERC20(account).totalSupply() returns (uint256) {
      // If the call to totalSupply doesn't revert, it's likely an ERC-20 token.
      return true;
    } catch {
      return false;
    }
  }

  //from https://ethereum.stackexchange.com/a/15642
  function _isContract(address _addr) private view returns (bool isContract){
  uint32 size;
  assembly {
    size := extcodesize(_addr)
  }
  return (size > 0);
}

  //PUBLIC GETTERS
  function getOrderMembersById(bytes32 orderId) public view returns (address creator, address partner) {
    return (_orders[orderId].creator, _orders[orderId].partner);
  }
  
  function getSubOrderByUser(address user, bytes32 orderId) public view returns (SubOrder memory subOrder) {
    return _orderOf[user][orderId];
  }

  //PUBLIC CONTRACT LOGIC FUNCTIONS
  function createOrder(address token, uint256 id, uint256 quantity) public returns (bool) {
    bytes4 interfaceID = _getAndValidateInterfaceID(token);
    _checkIfHasSufficientBalance(msg.sender,token, id, quantity, interfaceID, false);
    
    bytes32 randomId = bytes32(keccak256(abi.encode(block.timestamp, token, id, quantity, tx.gasprice, msg.sender)));
    _orders[randomId].creator = msg.sender;
    _orders[randomId].isActive = true;


    _orderOf[msg.sender][randomId] = SubOrder(
      token,
      interfaceID,
      id,
      quantity,
      Status.ProposalSubmited
    );
    
    emit StepCompleted(randomId, msg.sender, Status.ProposalSubmited);

    return true;
  }

  function joinsOrder(bytes32 orderId, address token, uint256 id, uint256 quantity) public isActive(orderId) returns (bool){
    (address creator, address partner) =  getOrderMembersById(orderId);
    require(partner == address(0), 'An address already joined this order.');
    require(creator != msg.sender, 'You are already the creator of the order.');

    bytes4 interfaceID = _getAndValidateInterfaceID(token);
    _checkIfHasSufficientBalance(msg.sender, token, id, quantity, interfaceID, false);

    _orders[orderId].partner = msg.sender;

    _orderOf[msg.sender][orderId] = SubOrder(
      token,
      interfaceID,
      id,
      quantity,
      Status.ProposalSubmited
    );

    emit StepCompleted(orderId, msg.sender, Status.ProposalSubmited);

    return true;
  }

  function transferFundsToSwap(bytes32 orderId) public isActive(orderId) returns (bool) {
    (address creator, address partner) =  getOrderMembersById(orderId);
    //verify if the msg.sender is the creator
    if (creator != msg.sender) revert MustBeTheCreator(msg.sender, creator);

    //verify the current state of the partner
    SubOrder memory partnerSubOrder = _orderOf[partner][orderId];
    if (partnerSubOrder.individualStatus != Status.ProposalSubmited) revert InvalidCurrentStatus(partner, partnerSubOrder.individualStatus, Status.ProposalSubmited);

    //check if the partner allowed the contract
    bool hasAllowed = _checkIfHasSufficientBalance(partner, partnerSubOrder.token, partnerSubOrder.tokenId, partnerSubOrder.quantity, partnerSubOrder.interfaceID, true);
    require(hasAllowed, "The partner did not allow the balance.");

    SubOrder memory creatorSubOrder = _orderOf[msg.sender][orderId];

    //verify the current state of the creator
    if (creatorSubOrder.individualStatus != Status.ProposalSubmited) revert InvalidCurrentStatus(msg.sender, creatorSubOrder.individualStatus, Status.ProposalSubmited);

    //confirm the token type and lock the funds in this contract
    _checkInterfaceIdAndDoTokenTransaction(creatorSubOrder, msg.sender, address(this), true);

    //update the current state of the order
    _orderOf[msg.sender][orderId].individualStatus = Status.TokenLocked;

    emit StepCompleted(orderId, msg.sender, Status.TokenLocked);

    return true;
  }

  function validateAndCompleteTheSwap(bytes32 orderId) public isActive(orderId) returns (bool) {
    (address creator, address partner) =  getOrderMembersById(orderId);
    //verify if the msg.sender is the partner
    if (partner != msg.sender) revert MustBeThePartner(msg.sender, partner);

    //verify the current state of the creator
    SubOrder memory creatorSubOrder = _orderOf[creator][orderId];
    if (creatorSubOrder.individualStatus != Status.TokenLocked) revert InvalidCurrentStatus(creator, creatorSubOrder.individualStatus, Status.TokenLocked);

    SubOrder memory partnerSubOrder = _orderOf[msg.sender][orderId];

    //send allowed funds from contract to creator
    _checkInterfaceIdAndDoTokenTransaction(partnerSubOrder, msg.sender, creator, true);
    //send funds from contract to partner
    _checkInterfaceIdAndDoTokenTransaction(creatorSubOrder, address(this), msg.sender, false);

    //update the current state of the order
    _orderOf[msg.sender][orderId].individualStatus = Status.Completed;
    _orders[orderId].isActive = false;

    emit StepCompleted(orderId, msg.sender, Status.Completed);

    return true;
  }

  function cancelOrder(bytes32 orderId) public isActive(orderId) returns (bool) {
    address creator =  _getCreator(orderId);
    //verify if the msg.sender is the creator
    if (creator != msg.sender) revert MustBeTheCreator(msg.sender, creator);

    SubOrder memory creatorSubOrder = _orderOf[creator][orderId];

    //verify the current state of the creator to check if there are tokens to be refunded
    if (creatorSubOrder.individualStatus == Status.TokenLocked) {
      _checkInterfaceIdAndDoTokenTransaction(creatorSubOrder, address(this), msg.sender, false);
    }

    _orders[orderId].isActive = false;

    emit StepCompleted(orderId, msg.sender, Status.Canceled);

    return true;
  }

  //PRIVATE CONTRACT LOGIC FUNCTIONS
  function _getAndValidateInterfaceID(address account) private view returns (bytes4){
    bytes4 interfaceID;
    if(!_isContract(account)) revert InvalidToken(account);

    if (ERC165Checker.supportsERC165(account)){
      if(ERC165Checker.supportsERC165InterfaceUnchecked(account, _ERC721_ID)){
        interfaceID = _ERC721_ID;
      } else 
      if(ERC165Checker.supportsERC165InterfaceUnchecked(account, _ERC1155_ID)){
        interfaceID = _ERC1155_ID;
      } else {
        revert InvalidToken(account);
      }
    } else {
      if (_isERC20(account)) {
        interfaceID = _ERC20_ID;
      } else {
        revert InvalidToken(account);
      }
    }

    return interfaceID;
  }

  function _checkIfHasSufficientBalance(address approver, address token, uint256 tokenId, uint256 quantity, bytes4 interfaceID, bool checkAllowance) private view returns (bool){
    uint256 balance;
    address owner;

    if (interfaceID == _ERC20_ID) {
      if(checkAllowance){
        balance = IERC20(token).allowance(approver, address(this));
        if (balance >= quantity) {
          return true;
        } else {
          return false;
        }
      } else {
        balance = IERC20(token).balanceOf(approver);
        if (balance >= quantity) {
          return true;
        } else {
          revert ERC20InsufficientBalance(approver, balance, quantity);
        }
      }
    } else
    if (interfaceID == _ERC721_ID) {
      if(checkAllowance){
        owner = IERC721(token).getApproved(tokenId);
        if (owner == approver) {
          return true;
        } else {
          return false;
        }
      } else {
        owner = IERC721(token).ownerOf(tokenId);
        if (owner == approver) {
          return true;
        } else {
          revert ERC721IncorrectOwner(approver, tokenId, owner);
        }
      }
    } else {
      if(checkAllowance){
        if (IERC1155(token).isApprovedForAll(approver, address(this))) {
          return true;
        } else {
          return false;
        }
      } else {
        balance = IERC1155(token).balanceOf(approver, tokenId);
        if (balance >= quantity) {
          return true;
        } else {
          revert ERC1155InsufficientBalance(approver, balance, quantity, tokenId);
        }
      }
    }
  }

  function _checkInterfaceIdAndDoTokenTransaction(SubOrder memory subOrder, address from, address to, bool isAllowance) private returns (bool) {
     //confirm the token type and send funds
    if (subOrder.interfaceID == _ERC20_ID) {
      if (isAllowance) {
        IERC20(subOrder.token).transferFrom(from, to, subOrder.quantity);
      } else {
        IERC20(subOrder.token).transfer(to, subOrder.quantity);
      }
    } else 
    if (subOrder.interfaceID == _ERC721_ID) {
      IERC721(subOrder.token).safeTransferFrom(from, to, subOrder.tokenId);
    } else {
      IERC1155(subOrder.token).safeTransferFrom(from, to, subOrder.tokenId, subOrder.quantity, '');
    }

    return true;
  }
}