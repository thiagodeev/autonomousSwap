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
    //can be an quantified ERC20 token or an NFT ID
    uint256 quantityOrId;
    //for the case of an ERC1155 token
    uint256 tokenId;
    Status individualStatus;
  }

  enum Status {
    Pending,
    Submited,
    Accepted,
    Rejected,
    Canceled
  }

  function createOrder(address token, bytes4 interfaceId, uint256 quantityOrId) public {
    bytes32 randomId = 0xe0d4f6e915eb01068ecd79ce922236bf16c38b2d88cccffcbc57ed53ef3b74aa;
    orders[randomId].creator = msg.sender;

    SubOrder memory subOrder = SubOrder(
      token,
      interfaceId,
      quantityOrId,
      0,
      Status.Submited
    );

    // MainOrder memory order = MainOrder(
    //   msg.sender,
    //   address(0),
    //   Status.Pending
    // );
  }

  function supportsInterface(address account, bytes4 interfaceId) external view returns (bool){
    return ERC165Checker.supportsInterface(account, interfaceId);
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