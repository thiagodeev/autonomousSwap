<script lang="ts">
  import { current_component } from "svelte/internal";
  import { AddressLike, BytesLike, BigNumberish, ContractTransactionResponse, ethers } from "ethers";
  import { autonomousSwap, partnerSubOrder, mainOrder, creatorState, generalState, creatorSubOrder, partnerState } from "../lib/stores.js";
  import { CreatorState, GeneralState, PartnerState } from "../lib/enums.js";
  import Card from "./base/Card.svelte";
  import ChooseToken from "./ChooseToken.svelte";


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

    let tokenId = 0;
    let quantity = 0;
    let orderId;
    const interfaceID = formElements[0].value;
    let token = formElements[1].value;

    if (interfaceID == tokenTypes.ERC20){
      quantity = formElements[2].value;
      orderId = formElements[3].value;
    } else 
    if (interfaceID == tokenTypes.ERC721){
      tokenId = formElements[2].value;
      orderId = formElements[3].value;
    } else {
      tokenId = formElements[2].value;
      quantity = formElements[3].value;
      orderId = formElements[4].value;
    }

    let _subOrder: [BytesLike, AddressLike, BigNumberish, BigNumberish];
    _subOrder = [
      orderId,
      token,
      tokenId,
      quantity
    ];

    const transactionResponse: ContractTransactionResponse = await _autonomousSwap.joinsOrder(..._subOrder);
    const transactionReceipt = await transactionResponse.wait();
    const eventLog = transactionReceipt.logs[0] as ethers.EventLog;
    const filter = {
      topics: [...eventLog.topics],
      data: eventLog.data
    }
    const logOutput = _autonomousSwap.interface.parseLog(filter).args;
    // console.log(logOutput)

    let { creator, } = await _autonomousSwap.getOrderMembersById(logOutput.orderId as BytesLike);
    // console.log(creator)

    let _creatorSubOrder = await _autonomousSwap.getSubOrderByUser(creator, orderId);

    creatorSubOrder.update(() => {
      return ({
        token: _creatorSubOrder.token,
        interfaceID: _creatorSubOrder.interfaceID,
        tokenId: _creatorSubOrder.tokenId,
        quantity: _creatorSubOrder.quantity,
        individualStatus: _creatorSubOrder.individualStatus
      })
    })

    mainOrder.update(() => {
      return ({
        orderId: logOutput.orderId,
        creator,
        partner: logOutput.who,
        isActive: true,
        isCreator: false
      })
    });

    partnerSubOrder.update(() => {
      return ({
        token,
        interfaceID,
        tokenId,
        quantity,
        individualStatus: logOutput.newStatus
      })
    })
    $creatorState = CreatorState.WaitingForPartnerJoin;
    $partnerState = PartnerState.WaitingFirstConfirmation;
    $generalState = GeneralState.OrderJoined;
  }

</script>

<Card>
  <h1 class="text-4xl font-bold text-slate-900 mb-8">Joining Order</h1>
  <ChooseToken isJoining={true} on:submit={onSubmit}/>
</Card>