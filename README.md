# AutonomousSwap
=====================================================

***Note: The Smart Contract is located at: core/contracts***
***Note: At the moment, the front-end only works on the Sepolia AutonomousSwap deployed instance (needs to change rpcUrl and contract addres in the js files to work in other networks).***

When you want to negotiate something with someone, don't you feel afraid of being the first to give/send and being deceived by the other party, who might run away without fulfilling the agreement?
The solution for this case in token transfers is: AutonomousSwap.
There is a smart contract that does the intermediation between the parties, only allowing the final trade in both of them prove and confirm they have the funds. In the end, the transfer is made at the same transaction, sending the tokens for both of them at the same time.

It's like an exchange in a MMORPG, where we first declare our itens to be traded, then confirm the partner's submition and finally complets the trade.

The stages are:
1. Order creation: One of the parties creates an order, passing:
    - the token address to be transferred (the Autonomous Swap accept either ERC20, ERC721, or ERC1155);
    - token ID (can be 0 for ERC20 tokens);
    - quantity (can be 0 for ERC721 NFTs);

    This step also validates:
      - if token address is either ERC20, ERC721 or ERC1155;
      - if creator has suficiente balance;

This process generates an random 'orderID' that identifies the order, write it down. With this orderID, the parter can then:

2. Join an order: A partner can join an existing/active order using an orderID. Need pass:
    - the orderID
    - the token address to be transferred (the Autonomous Swap accept either ERC20, ERC721, or ERC1155);
    - token ID (can be 0 for ERC20 tokens);
    - quantity (can be 0 for ERC721 NFTs);

    This step validates the same validations as the previous step, plus:
      - if the order does not have any partner who has already joined;
      - if it's not the creator himself;

After that, both must approve the amount/id submitted in the order to follow the next stages:

3. Funds the contract: The creator transfer the funds to the AutonomousSwap token; just need to pass the orderID. This step performs many verifications, the main ones are:
    - check the stages in witch both creator and partner are (if is neither too late nor too early);
    - check if the partner has already allowed the contract in his submitted amount (to not be early-deceived);

Then, to finish, the parter does:

4. Transfer the funds: The partner calling the function finished the order/swap. The function does in a single transaction:
    - checks the stages in witch both creator and partner are (if is neither too late nor too early);
    - transfer the creator funds locked in the contract to the parner address;
    - transfer the partner funds directly to the creator's address;

It's finished! You and your partner swapped tokens with each other without concern!

!!!!WAIT THERE! WHAT IF AFTER THE THIRD STAGE I REGRET MY DECISION? HOW CAN I HAVE MY TOKENS BACK?!!!!
Worry not! There is a fifth stage:

5. Cancel order: The creator can cancel his order. By doing so, any funds of him locked in the contract will be sent back.


That is it! Done :D

=====================================================

For you to test:
Random ERC20 token: 0x2E6dd9771E607259F9F52AcD2A99Ba7A6483952d  
Random ERC721 token: 0xb829d0931FE3eFDE1E5E64BF8719ec4DFF51c9Da  
Random ERC1155 token: 0x97C998bDbBc40a257FdE53e781de949c300F5b20  


**Deployed links:**

**Sepolia** flattened deployment: 0x9a642b656ea04452AbA6e85e11f669a782E5B226  
Verification link: https://sepolia.etherscan.io/address/0x9a642b656ea04452aba6e85e11f669a782e5b226#code  
<!-- Mantle deployment: 0x89E93e36A9ac7059a7138F7b3cac85F3Ebc8725f -->
**Mantle** flattened deployment: 0x1DD666CbBD10996584C9Cdce6518df0274BaEFD3  
  Verification link: https://explorer.testnet.mantle.xyz/address/0x1DD666CbBD10996584C9Cdce6518df0274BaEFD3/contracts#address-tabs  

**Polygon** flattened deployment: 0xcf1D6e6a704b0717D19dD4740CA0aD7aaE2415AD  
  Verification link: https://testnet-zkevm.polygonscan.com/address/0xcf1d6e6a704b0717d19dd4740ca0ad7aae2415ad#code 

**Scroll** flattened deployment: 0xcf1D6e6a704b0717D19dD4740CA0aD7aaE2415AD  
  Verification link: https://sepolia-blockscout.scroll.io/address/0xcf1D6e6a704b0717D19dD4740CA0aD7aaE2415AD/contracts#address-tabs  
  Verification link: https://sepolia.scrollscan.dev/address/0xcf1d6e6a704b0717d19dd4740ca0ad7aae2415ad#code  

**Filecoin** flattened deployment: 0xcf1D6e6a704b0717D19dD4740CA0aD7aaE2415AD  
  Verification link (solidity 8.19): https://calibration.filfox.info/en/address/0xa5747753Ef82F9140c7C05C6179bA7a5e86eB345?t=3  

<!-- npx hardhat verify --contract contracts/AutonomousSwap_flattened.sol:AutonomousSwap --network scrollSepolia 0xcf1D6e6a704b0717D19dD4740CA0aD7aaE2415AD -->