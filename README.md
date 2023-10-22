# AutonomousSwap
=====================================================

***Note: The Smart Contract is located at: core/contracts***

Get up and running with Svelte, Typescript, Tailwind and Vite. Also includes testing setup using Jest.

Installation
------------

```
npx degit "srmullen/sttv#main" my_app
cd my_app
npm install
```

Scripts
-------

### Start a development server

`npm run dev`

### Run tests

`npm run test`
or
`npm run test:watch`

### Build the application

`npm run build`

### Serve the application

`npm run serve`When you want to negotiate something with someone, don't you feel afraid of being the first to give/send and being deceived by the other party, who might run away without fulfilling the agreement?
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