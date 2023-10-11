// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract AutonomousSwap {

  //random number for ERC20, just to identify it
  bytes4 private constant ERC20_ID = 0xec20ec20;
  bytes4 private constant ERC721_ID = 0x80ac58cd;
  bytes4 private constant ERC1155_ID = 0xd9b67a26;

  mapping (bytes32 orderID => MainOrder) public orders;
  mapping (address user => mapping (bytes32 orderID => SubOrder)) public orderOf;

  struct MainOrder {
    address creator;
    address partner;
    Status status;
  }

  struct SubOrder {
    address token;
    bytes4 tokenType;
    uint256 interfaceId; //for the case of an ERC721/ERC1155 token
    uint256 quantity;
    Status individualStatus;
  }

  enum Status {
    Pending,
    Submited,
    Accepted,
    Rejected,
    Canceled
  }

  error InvalidToken(address tokenAddress);
  error ERC20InsufficientBalance(address sender, uint256 balance, uint256 needed);
  error ERC721IncorrectOwner(address sender, uint256 tokenId, address owner);
  error ERC1155InsufficientBalance(address sender, uint256 balance, uint256 needed, uint256 tokenId);

  function createOrder(address token, uint256 id, uint256 quantity) public {
    bytes4 interfaceId = _getAndValidateInterfaceId(token);
    _checkIfHasSufficientBalance(token, id, quantity, interfaceId);
    
    
    bytes32 randomId = 0xe0d4f6e915eb01068ecd79ce922236bf16c38b2d88cccffcbc57ed53ef3b74aa;
    orders[randomId].creator = msg.sender;


    orderOf[msg.sender][randomId] = SubOrder(
      token,
      interfaceId,
      id,
      quantity,

    );
    
  }

  function _getAndValidateInterfaceId(address account) internal view returns (bytes4){
    bytes4 interfaceId;

    if (ERC165Checker.supportsERC165(account)){
      if(ERC165Checker.supportsERC165InterfaceUnchecked(account, ERC721_ID)){
        interfaceId = ERC721_ID;
      } else 
      if(ERC165Checker.supportsERC165InterfaceUnchecked(account, ERC1155_ID)){
        interfaceId = ERC1155_ID;
      }
    } else {
      if (_isERC20(account)) {
        interfaceId = ERC20_ID;
      } else {
        revert InvalidToken(account);
      }
    }

    return interfaceId;
  }

  function _checkIfHasSufficientBalance(address token, uint256 tokenId, uint256 quantity, bytes4 interfaceId) internal view returns (bool){
    uint256 balance;
    address owner;

    if (interfaceId == ERC20_ID) {
      balance = IERC20(token).balanceOf(msg.sender);
      if (balance >= quantity) {
        return true;
      } else {
        revert ERC20InsufficientBalance(msg.sender, balance, quantity);
      }
    } else
    if (interfaceId == ERC721_ID) {
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

  function _isERC20(address account) internal view returns (bool){
    try IERC20(account).totalSupply() returns (uint256) {
      // If the call to totalSupply doesn't revert, it's likely an ERC-20 token.
      return true;
    } catch {
      return false;
    }
  }

  function _isERC721(address account) internal view returns (bool){
    return ERC165Checker.supportsInterface(account, ERC721_ID);
  }

  function _isERC1155(address account) internal view returns (bool){
    return ERC165Checker.supportsInterface(account, ERC1155_ID);
  }
}