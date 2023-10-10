// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/utils/introspection/ERC165Checker.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";

contract AutonomousSwap {

  bytes4 private constant ERC721_ID = 0x80ac58cd;
  bytes4 private constant ERC1155_ID = 0xd9b67a26;


  // struct Order {
  //   address creator;
  //   address partner;

  // }

  // enum Status {
  //   Pending,
  //   Submited,
  //   Accepted,
  //   Rejected,
  //   Canceled
  // }

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