<script lang="ts">
  import { current_component } from "svelte/internal";
  import { AddressLike, BytesLike, BigNumberish, ContractTransactionResponse, ethers, id } from "ethers";
  import { autonomousSwap, partnerSubOrder, mainOrder, creatorSubOrder, creatorState, generalState, partnerState, signer } from "../lib/stores.js";
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
  let error = null;

  async function onSubmit(e) {
    const formElements = e.target.elements;
    const orderId = formElements[0].value;
    let _signer = await $signer.getAddress()

    let { creator, partner } = await _autonomousSwap.getOrderMembersById(orderId as BytesLike);

    if(creator == _signer){
      let _creatorSubOrder = await _autonomousSwap.getSubOrderByUser(creator, orderId);
      let _partnerSubOrder = await _autonomousSwap.getSubOrderByUser(partner, orderId);
      
      // console.log(_creatorSubOrder)
      // console.log(_partnerSubOrder)

      creatorSubOrder.update(() => {
        return ({
          token: _creatorSubOrder.token,
          interfaceID: _creatorSubOrder.interfaceID,
          tokenId: _creatorSubOrder.tokenId,
          quantity: _creatorSubOrder.quantity,
          individualStatus: _creatorSubOrder.individualStatus
        })
      })

      partnerSubOrder.update(() => {
        return ({
          token: _partnerSubOrder.token,
          interfaceID: _partnerSubOrder.interfaceID,
          tokenId: _partnerSubOrder.tokenId,
          quantity: _partnerSubOrder.quantity,
          individualStatus: _partnerSubOrder.individualStatus
        })
      })

      mainOrder.update(() => {
        return ({
          orderId: orderId,
          creator: _signer,
          partner: partner,
          isActive: true,
          isCreator: true
        })
      });

    } else
    if (partner == _signer) {
      let _creatorSubOrder = await _autonomousSwap.getSubOrderByUser(creator, orderId);
      let _partnerSubOrder = await _autonomousSwap.getSubOrderByUser(partner, orderId);
      
      // console.log(_creatorSubOrder)
      // console.log(_partnerSubOrder)

      creatorSubOrder.update(() => {
        return ({
          token: _creatorSubOrder.token,
          interfaceID: _creatorSubOrder.interfaceID,
          tokenId: _creatorSubOrder.tokenId,
          quantity: _creatorSubOrder.quantity,
          individualStatus: _creatorSubOrder.individualStatus
        })
      })

      partnerSubOrder.update(() => {
        return ({
          token: _partnerSubOrder.token,
          interfaceID: _partnerSubOrder.interfaceID,
          tokenId: _partnerSubOrder.tokenId,
          quantity: _partnerSubOrder.quantity,
          individualStatus: _partnerSubOrder.individualStatus
        })
      })

      mainOrder.update(() => {
        return ({
          orderId: orderId,
          creator: creator,
          partner: _signer,
          isActive: true,
          isCreator: false
        })
      });
    } else {
      error = "Invalid orderId";
      console.log(error)
      throw new Error(error);
      return
    }

    
    console.log($mainOrder)
    console.log($creatorSubOrder)
    console.log($partnerSubOrder)
    
    if ($creatorSubOrder.)


    // let _subOrder: [BytesLike, AddressLike, BigNumberish, BigNumberish];
    // _subOrder = [
    //   orderId,
    //   token,
    //   tokenId,
    //   quantity
    // ];

    // const transactionResponse: ContractTransactionResponse = await _autonomousSwap.joinsOrder(..._subOrder);
    // const transactionReceipt = await transactionResponse.wait();
    // const eventLog = transactionReceipt.logs[0] as ethers.EventLog;
    // const filter = {
    //   topics: [...eventLog.topics],
    //   data: eventLog.data
    // }
    // const logOutput = _autonomousSwap.interface.parseLog(filter).args;
    // // console.log(logOutput)

    // let { creator, } = await _autonomousSwap.getOrderMembersById(logOutput.orderId as BytesLike);
    // console.log(creator)

    // mainOrder.update(() => {
    //   return ({
    //     orderId: logOutput.orderId,
    //     creator,
    //     partner: logOutput.who,
    //     isActive: true,
    //     isCreator: false
    //   })
    // });

    // partnerSubOrder.update(() => {
    //   return ({
    //     token,
    //     interfaceID,
    //     tokenId,
    //     quantity,
    //     individualStatus: logOutput.newStatus
    //   })
    // })

    // $partnerState = PartnerState.WaitingFirstConfirmation;
    // $generalState = GeneralState.OrderJoined;
  }

</script>

<Card>
  <h1 class="text-4xl font-bold text-slate-900 mb-8">Joining Order</h1>
  <form on:submit|preventDefault={onSubmit}>
    <!-- OrderId -->
    <div class="relative mb-3">
      <label
      for="orderIdnumberReturn"
      class="relative block overflow-hidden rounded-md border border-gray-200 px-3 pt-3 shadow-sm focus-within:border-blue-600 focus-within:ring-1 focus-within:ring-blue-600"
      >
        <input
          type="text"
          id="orderIdnumberReturn"
          required
          class="peer h-8 w-full border-none bg-transparent p-0 placeholder-transparent focus:border-transparent focus:outline-none focus:ring-0 sm:text-sm"
          placeholder="Order ID"
        />

        <span
          class="absolute start-3 top-3 -translate-y-1/2 text-xs text-gray-700 transition-all peer-placeholder-shown:top-1/2 peer-placeholder-shown:text-sm peer-focus:top-3 peer-focus:text-xs"
        >
          Order ID
        </span>
      </label>
    </div>

    <!--Submit button-->
    <button
      type="submit"
      class="inline-block rounded border border-indigo-600 bg-indigo-600 px-12 py-3 text-sm font-medium text-white hover:bg-transparent hover:text-indigo-600 focus:outline-none focus:ring active:text-indigo-500">
        Submit
    </button>
  </form>
  {#if error != null}
    <p>INVALID ORDER: {error}</p>
  {/if}
</Card>