<script lang="ts">
  import { current_component } from "svelte/internal";
  import Card from "./base/Card.svelte";
  import ChooseToken from "./ChooseToken.svelte";
  import { autonomousSwap, creatorSubOrder, mainOrder } from "../lib/stores.js";
  import { AddressLike, BigNumberish, ContractTransactionResponse, ethers } from "ethers";


  let _autonomousSwap: AutonomousSwapContract;
  autonomousSwap.subscribe((value) => {
    _autonomousSwap = value;
  })

  let tokenTypes = {
    ERC20: '0xec20ec20',
    ERC721: '0x80ac58cd',
    ERC1155: '0xd9b67a26'
  }

  async function onSubmit(e) {
    const formElements = e.target.elements

    const interfaceID = formElements[0].value;
    let token = formElements[1].value;
    let tokenId = 0;
    let quantity = 0;

    if (interfaceID == tokenTypes.ERC20){
      quantity = formElements[2].value;
    } else 
    if (interfaceID == tokenTypes.ERC721){
      tokenId = formElements[2].value;
    } else {
      tokenId = formElements[2].value;
      quantity = formElements[3].value;
    }

    let _subOrder: [AddressLike, BigNumberish, BigNumberish];
    _subOrder = [
      token,
      tokenId,
      quantity
    ];

    const transactionResponse: ContractTransactionResponse = await _autonomousSwap.createOrder(..._subOrder);
    const transactionReceipt = await transactionResponse.wait();
    const eventLog = transactionReceipt.logs[0] as ethers.EventLog;
    // const eventFragment = eventLog.fragment as ((string | ethers.EventFragment) & (string | ethers.EventFragment));
    const filter = {
      topics: [...eventLog.topics],
      data: eventLog.data
    }
    const output = _autonomousSwap.interface.parseLog(filter).args;

    // console.log(_autonomousSwap.interface.decodeEventLog(test.fragment as any, test.data, test.topics))
    // console.log(_autonomousSwap.interface.parseLog(teste))
    console.log(output)

    mainOrder.update(() => {
      return ({
        orderId: output.orderId,
        creator: output.who,
        isActive: true
      })
    });

    creatorSubOrder.update(() => {
      return ({
        token,
        interfaceID,
        tokenId,
        quantity,
        individualStatus: output.newStatus
      })
    })
  }

</script>

<Card>
  <h1 class="text-4xl font-bold text-slate-900 mb-8">Order creation</h1>
  <ChooseToken on:submit={onSubmit}/>

  {#if $mainOrder != null}
    <p>Your orderId is {$mainOrder.orderId}</p>
  {/if}
</Card>