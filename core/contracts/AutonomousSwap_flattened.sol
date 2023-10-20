// Sources flattened with hardhat v2.18.0 https://hardhat.org

// SPDX-License-Identifier: GPL-3.0-or-later AND MIT

// File @openzeppelin/contracts/utils/introspection/IERC165.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (utils/introspection/IERC165.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}


// File @openzeppelin/contracts/token/ERC1155/IERC1155.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC1155/IERC1155.sol)

pragma solidity ^0.8.20;

/**
 * @dev Required interface of an ERC1155 compliant contract, as defined in the
 * https://eips.ethereum.org/EIPS/eip-1155[EIP].
 */
interface IERC1155 is IERC165 {
    /**
     * @dev Emitted when `value` amount of tokens of type `id` are transferred from `from` to `to` by `operator`.
     */
    event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value);

    /**
     * @dev Equivalent to multiple {TransferSingle} events, where `operator`, `from` and `to` are the same for all
     * transfers.
     */
    event TransferBatch(
        address indexed operator,
        address indexed from,
        address indexed to,
        uint256[] ids,
        uint256[] values
    );

    /**
     * @dev Emitted when `account` grants or revokes permission to `operator` to transfer their tokens, according to
     * `approved`.
     */
    event ApprovalForAll(address indexed account, address indexed operator, bool approved);

    /**
     * @dev Emitted when the URI for token type `id` changes to `value`, if it is a non-programmatic URI.
     *
     * If an {URI} event was emitted for `id`, the standard
     * https://eips.ethereum.org/EIPS/eip-1155#metadata-extensions[guarantees] that `value` will equal the value
     * returned by {IERC1155MetadataURI-uri}.
     */
    event URI(string value, uint256 indexed id);

    /**
     * @dev Returns the value of tokens of token type `id` owned by `account`.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function balanceOf(address account, uint256 id) external view returns (uint256);

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {balanceOf}.
     *
     * Requirements:
     *
     * - `accounts` and `ids` must have the same length.
     */
    function balanceOfBatch(
        address[] calldata accounts,
        uint256[] calldata ids
    ) external view returns (uint256[] memory);

    /**
     * @dev Grants or revokes permission to `operator` to transfer the caller's tokens, according to `approved`,
     *
     * Emits an {ApprovalForAll} event.
     *
     * Requirements:
     *
     * - `operator` cannot be the caller.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns true if `operator` is approved to transfer ``account``'s tokens.
     *
     * See {setApprovalForAll}.
     */
    function isApprovedForAll(address account, address operator) external view returns (bool);

    /**
     * @dev Transfers a `value` amount of tokens of type `id` from `from` to `to`.
     *
     * WARNING: This function can potentially allow a reentrancy attack when transferring tokens
     * to an untrusted contract, when invoking {onERC1155Received} on the receiver.
     * Ensure to follow the checks-effects-interactions pattern and consider employing
     * reentrancy guards when interacting with untrusted contracts.
     *
     * Emits a {TransferSingle} event.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - If the caller is not `from`, it must have been approved to spend ``from``'s tokens via {setApprovalForAll}.
     * - `from` must have a balance of tokens of type `id` of at least `value` amount.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155Received} and return the
     * acceptance magic value.
     */
    function safeTransferFrom(address from, address to, uint256 id, uint256 value, bytes calldata data) external;

    /**
     * @dev xref:ROOT:erc1155.adoc#batch-operations[Batched] version of {safeTransferFrom}.
     *
     *
     * WARNING: This function can potentially allow a reentrancy attack when transferring tokens
     * to an untrusted contract, when invoking {onERC1155BatchReceived} on the receiver.
     * Ensure to follow the checks-effects-interactions pattern and consider employing
     * reentrancy guards when interacting with untrusted contracts.
     *
     * Emits a {TransferBatch} event.
     *
     * Requirements:
     *
     * - `ids` and `values` must have the same length.
     * - If `to` refers to a smart contract, it must implement {IERC1155Receiver-onERC1155BatchReceived} and return the
     * acceptance magic value.
     */
    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external;
}


// File @openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC1155/IERC1155Receiver.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface that must be implemented by smart contracts in order to receive
 * ERC-1155 token transfers.
 */
interface IERC1155Receiver is IERC165 {
    /**
     * @dev Handles the receipt of a single ERC1155 token type. This function is
     * called at the end of a `safeTransferFrom` after the balance has been updated.
     *
     * NOTE: To accept the transfer, this must return
     * `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))`
     * (i.e. 0xf23a6e61, or its own function selector).
     *
     * @param operator The address which initiated the transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param id The ID of the token being transferred
     * @param value The amount of tokens being transferred
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC1155Received(address,address,uint256,uint256,bytes)"))` if transfer is allowed
     */
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);

    /**
     * @dev Handles the receipt of a multiple ERC1155 token types. This function
     * is called at the end of a `safeBatchTransferFrom` after the balances have
     * been updated.
     *
     * NOTE: To accept the transfer(s), this must return
     * `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))`
     * (i.e. 0xbc197c81, or its own function selector).
     *
     * @param operator The address which initiated the batch transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param ids An array containing ids of each token being transferred (order and length must match values array)
     * @param values An array containing amounts of each token being transferred (order and length must match ids array)
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC1155BatchReceived(address,address,uint256[],uint256[],bytes)"))` if transfer is allowed
     */
    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external returns (bytes4);
}


// File @openzeppelin/contracts/utils/introspection/ERC165.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (utils/introspection/ERC165.sol)

pragma solidity ^0.8.20;

/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 */
abstract contract ERC165 is IERC165 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}


// File @openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC1155/utils/ERC1155Holder.sol)

pragma solidity ^0.8.20;


/**
 * @dev Simple implementation of `IERC1155Receiver` that will allow a contract to hold ERC1155 tokens.
 *
 * IMPORTANT: When inheriting this contract, you must include a way to use the received tokens, otherwise they will be
 * stuck.
 */
abstract contract ERC1155Holder is ERC165, IERC1155Receiver {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return interfaceId == type(IERC1155Receiver).interfaceId || super.supportsInterface(interfaceId);
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] memory,
        uint256[] memory,
        bytes memory
    ) public virtual override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }
}


// File @openzeppelin/contracts/token/ERC721/IERC721.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC721/IERC721.sol)

pragma solidity ^0.8.20;

/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon
     *   a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or
     *   {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon
     *   a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
     * or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
     * understand this adds an external call which potentially creates a reentrancy vulnerability.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 tokenId) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the address zero.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}


// File @openzeppelin/contracts/token/ERC721/IERC721Receiver.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC721/IERC721Receiver.sol)

pragma solidity ^0.8.20;

/**
 * @title ERC721 token receiver interface
 * @dev Interface for any contract that wants to support safeTransfers
 * from ERC721 asset contracts.
 */
interface IERC721Receiver {
    /**
     * @dev Whenever an {IERC721} `tokenId` token is transferred to this contract via {IERC721-safeTransferFrom}
     * by `operator` from `from`, this function is called.
     *
     * It must return its Solidity selector to confirm the token transfer.
     * If any other value is returned or the interface is not implemented by the recipient, the transfer will be
     * reverted.
     *
     * The selector can be obtained in Solidity with `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4);
}


// File @openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC721/utils/ERC721Holder.sol)

pragma solidity ^0.8.20;

/**
 * @dev Implementation of the {IERC721Receiver} interface.
 *
 * Accepts all token transfers.
 * Make sure the contract is able to use its token with {IERC721-safeTransferFrom}, {IERC721-approve} or
 * {IERC721-setApprovalForAll}.
 */
abstract contract ERC721Holder is IERC721Receiver {
    /**
     * @dev See {IERC721Receiver-onERC721Received}.
     *
     * Always returns `IERC721Receiver.onERC721Received.selector`.
     */
    function onERC721Received(address, address, uint256, bytes memory) public virtual returns (bytes4) {
        return this.onERC721Received.selector;
    }
}


// File @openzeppelin/contracts/utils/introspection/ERC165Checker.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (utils/introspection/ERC165Checker.sol)

pragma solidity ^0.8.20;

/**
 * @dev Library used to query support of an interface declared via {IERC165}.
 *
 * Note that these functions return the actual result of the query: they do not
 * `revert` if an interface is not supported. It is up to the caller to decide
 * what to do in these cases.
 */
library ERC165Checker {
    // As per the EIP-165 spec, no interface should ever match 0xffffffff
    bytes4 private constant INTERFACE_ID_INVALID = 0xffffffff;

    /**
     * @dev Returns true if `account` supports the {IERC165} interface.
     */
    function supportsERC165(address account) internal view returns (bool) {
        // Any contract that implements ERC165 must explicitly indicate support of
        // InterfaceId_ERC165 and explicitly indicate non-support of InterfaceId_Invalid
        return
            supportsERC165InterfaceUnchecked(account, type(IERC165).interfaceId) &&
            !supportsERC165InterfaceUnchecked(account, INTERFACE_ID_INVALID);
    }

    /**
     * @dev Returns true if `account` supports the interface defined by
     * `interfaceId`. Support for {IERC165} itself is queried automatically.
     *
     * See {IERC165-supportsInterface}.
     */
    function supportsInterface(address account, bytes4 interfaceId) internal view returns (bool) {
        // query support of both ERC165 as per the spec and support of _interfaceId
        return supportsERC165(account) && supportsERC165InterfaceUnchecked(account, interfaceId);
    }

    /**
     * @dev Returns a boolean array where each value corresponds to the
     * interfaces passed in and whether they're supported or not. This allows
     * you to batch check interfaces for a contract where your expectation
     * is that some interfaces may not be supported.
     *
     * See {IERC165-supportsInterface}.
     */
    function getSupportedInterfaces(
        address account,
        bytes4[] memory interfaceIds
    ) internal view returns (bool[] memory) {
        // an array of booleans corresponding to interfaceIds and whether they're supported or not
        bool[] memory interfaceIdsSupported = new bool[](interfaceIds.length);

        // query support of ERC165 itself
        if (supportsERC165(account)) {
            // query support of each interface in interfaceIds
            for (uint256 i = 0; i < interfaceIds.length; i++) {
                interfaceIdsSupported[i] = supportsERC165InterfaceUnchecked(account, interfaceIds[i]);
            }
        }

        return interfaceIdsSupported;
    }

    /**
     * @dev Returns true if `account` supports all the interfaces defined in
     * `interfaceIds`. Support for {IERC165} itself is queried automatically.
     *
     * Batch-querying can lead to gas savings by skipping repeated checks for
     * {IERC165} support.
     *
     * See {IERC165-supportsInterface}.
     */
    function supportsAllInterfaces(address account, bytes4[] memory interfaceIds) internal view returns (bool) {
        // query support of ERC165 itself
        if (!supportsERC165(account)) {
            return false;
        }

        // query support of each interface in interfaceIds
        for (uint256 i = 0; i < interfaceIds.length; i++) {
            if (!supportsERC165InterfaceUnchecked(account, interfaceIds[i])) {
                return false;
            }
        }

        // all interfaces supported
        return true;
    }

    /**
     * @notice Query if a contract implements an interface, does not check ERC165 support
     * @param account The address of the contract to query for support of an interface
     * @param interfaceId The interface identifier, as specified in ERC-165
     * @return true if the contract at account indicates support of the interface with
     * identifier interfaceId, false otherwise
     * @dev Assumes that account contains a contract that supports ERC165, otherwise
     * the behavior of this method is undefined. This precondition can be checked
     * with {supportsERC165}.
     *
     * Some precompiled contracts will falsely indicate support for a given interface, so caution
     * should be exercised when using this function.
     *
     * Interface identification is specified in ERC-165.
     */
    function supportsERC165InterfaceUnchecked(address account, bytes4 interfaceId) internal view returns (bool) {
        // prepare call
        bytes memory encodedParams = abi.encodeCall(IERC165.supportsInterface, (interfaceId));

        // perform static call
        bool success;
        uint256 returnSize;
        uint256 returnValue;
        assembly {
            success := staticcall(30000, account, add(encodedParams, 0x20), mload(encodedParams), 0x00, 0x20)
            returnSize := returndatasize()
            returnValue := mload(0x00)
        }

        return success && returnSize >= 0x20 && returnValue > 0;
    }
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v5.0.0

// Original license: SPDX_License_Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}


// File contracts/AutonomousSwap.sol

// Original license: SPDX_License_Identifier: GPL-3.0-or-later
pragma solidity ^0.8.20;






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
