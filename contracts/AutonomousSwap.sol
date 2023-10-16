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

  error InvalidToken(address tokenAddress);
  error MustBeTheCreator(address caller, address creator);
  error MustBeThePartner(address caller, address creator);
  error PartnerAlreadyFilled(address caller, address partner);
  error InvalidCurrentStatus(address who, Status current, Status needed);

  error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);
  error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);
  error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);

  modifier isActive(bytes32 orderId) {
    require(_orders[orderId].isActive == true, 'This order is not active.');
    _;
  }

  function _getCreator(bytes32 orderId) private view returns (address) {
    return _orders[orderId].creator;
  }

  function _getPartner(bytes32 orderId) private view returns (address) {
    return _orders[orderId].partner;
  }

  function getOrderMembersById(bytes32 orderId) public view returns (address creator, address partner) {
    return (_orders[orderId].creator, _orders[orderId].partner);
  }
  
  function getOrderByUser(address user, bytes32 orderId) public view returns (SubOrder memory subOrder) {
    return _orderOf[user][orderId];
  }

  function createOrder(address token, uint256 id, uint256 quantity) public returns (bool) {
    bytes4 interfaceID = _getAndValidateInterfaceID(token);
    _checkIfHasSufficientBalance(token, id, quantity, interfaceID);
    
    
    bytes32 randomId = 0xe0d4f6e915eb01068ecd79ce922236bf16c38b2d88cccffcbc57ed53ef3b74aa;
    _orders[randomId].creator = msg.sender;
    _orders[randomId].isActive = true;


    _orderOf[msg.sender][randomId] = SubOrder(
      token,
      interfaceID,
      id,
      quantity,
      Status.ProposalSubmited
    );
    
    return true;
  }

  function joinsOrder(bytes32 orderId, address token, uint256 id, uint256 quantity) public isActive(orderId) returns (bool){
    address partner = _getPartner(orderId);
    if (partner != address(0)) revert PartnerAlreadyFilled(msg.sender, partner);
    require(_getCreator(orderId) != msg.sender, 'You are already the creator of the order.');

    bytes4 interfaceID = _getAndValidateInterfaceID(token);
    _checkIfHasSufficientBalance(token, id, quantity, interfaceID);

    _orders[orderId].partner = msg.sender;

    _orderOf[msg.sender][orderId] = SubOrder(
      token,
      interfaceID,
      id,
      quantity,
      Status.ProposalSubmited
    );

    return true;
  }

  function transferFundsToSwap(bytes32 orderId) public isActive(orderId) returns (bool) {
    (address creator, address partner) =  getOrderMembersById(orderId);
    if (creator != msg.sender) revert MustBeTheCreator(msg.sender, creator);

    //verify the current state of the partner
    Status partnerStatus = _orderOf[partner][orderId].individualStatus;
    if (partnerStatus != Status.ProposalSubmited) revert InvalidCurrentStatus(partner, partnerStatus, Status.ProposalSubmited);

    //verify the current state of the creator
    SubOrder memory subOrder = _orderOf[msg.sender][orderId];
    if (subOrder.individualStatus != Status.ProposalSubmited) revert InvalidCurrentStatus(msg.sender, subOrder.individualStatus, Status.ProposalSubmited);

    //confirm the token type and lock the funds in this contract
    if (subOrder.interfaceID == _ERC20_ID) {
      IERC20(subOrder.token).transferFrom(msg.sender, address(this), subOrder.quantity);
    } else 
    if (subOrder.interfaceID == _ERC721_ID) {
      IERC721(subOrder.token).safeTransferFrom(msg.sender, address(this), subOrder.tokenId);
    } else {
      IERC1155(subOrder.token).safeTransferFrom(msg.sender, address(this), subOrder.tokenId, subOrder.quantity, '');
    }

    //update the current state of the order
    _orderOf[msg.sender][orderId].individualStatus = Status.TokenLocked;

    return true;
  }

  function validateAndCompleteTheSwap(bytes32 orderId) public isActive(orderId) returns (bool) {
    (address creator, address partner) =  getOrderMembersById(orderId);
    if (partner != msg.sender) revert MustBeThePartner(msg.sender, partner);

    //verify the current state of the creator
    Status creatorStatus = _orderOf[creator][orderId].individualStatus;
    if (creatorStatus != Status.TokenLocked) revert InvalidCurrentStatus(creator, creatorStatus, Status.TokenLocked);

    SubOrder memory creatorSubOrder = _orderOf[creator][orderId];
    SubOrder memory partnerSubOrder = _orderOf[msg.sender][orderId];

    //confirm the token type and lock the funds in this contract
    if (subOrder.interfaceID == _ERC20_ID) {
      IERC20(subOrder.token).transferFrom(msg.sender, address(this), subOrder.quantity);
    } else 
    if (subOrder.interfaceID == _ERC721_ID) {
      IERC721(subOrder.token).safeTransferFrom(msg.sender, address(this), subOrder.tokenId);
    } else {
      IERC1155(subOrder.token).safeTransferFrom(msg.sender, address(this), subOrder.tokenId, subOrder.quantity, '');
    }

    //update the current state of the order
    _orderOf[msg.sender][orderId].individualStatus = Status.TokenLocked;

    return true;
  }

  function _getAndValidateInterfaceID(address account) private view returns (bytes4){
    bytes4 interfaceID;

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

  function _checkIfHasSufficientBalance(address token, uint256 tokenId, uint256 quantity, bytes4 interfaceID) private view returns (bool){
    uint256 balance;
    address owner;

    if (interfaceID == _ERC20_ID) {
      balance = IERC20(token).balanceOf(msg.sender);
      if (balance >= quantity) {
        return true;
      } else {
        revert ERC20InsufficientBalance(msg.sender, balance, quantity);
      }
    } else
    if (interfaceID == _ERC721_ID) {
      owner = IERC721(token).ownerOf(tokenId);
      if (owner == msg.sender) {
        return true;
      } else {
        revert ERC721IncorrectOwner(msg.sender, tokenId, owner);
      }
    } else {
      balance = IERC1155(token).balanceOf(msg.sender, tokenId);
      if (balance >= quantity) {
        return true;
      } else {
        revert ERC1155InsufficientBalance(msg.sender, balance, quantity, tokenId);
      }
    }
  }

  function _doTokenTransaction(SubOrder subOrder, address from, address to) private  {
     //confirm the token type and lock the funds in this contract
    if (subOrder.interfaceID == _ERC20_ID) {
      IERC20(subOrder.token).transferFrom(msg.sender, address(this), subOrder.quantity);
    } else 
    if (subOrder.interfaceID == _ERC721_ID) {
      IERC721(subOrder.token).safeTransferFrom(msg.sender, address(this), subOrder.tokenId);
    } else {
      IERC1155(subOrder.token).safeTransferFrom(msg.sender, address(this), subOrder.tokenId, subOrder.quantity, '');
    }
  }

  function _isERC20(address account) private view returns (bool){
    try IERC20(account).totalSupply() returns (uint256) {
      // If the call to totalSupply doesn't revert, it's likely an ERC-20 token.
      return true;
    } catch {
      return false;
    }
  }

  // function _isERC721(address account) private view returns (bool){
  //   return ERC165Checker.supportsInterface(account, _ERC721_ID);
  // }

  // function _isERC1155(address account) private view returns (bool){
  //   return ERC165Checker.supportsInterface(account, _ERC1155_ID);
  // }
}