<script lang="ts">
  import { CreatorState, PartnerState } from "../../lib/enums.js";
  import { autonomousSwap, mainOrder, partnerSubOrder, creatorState, partnerState, creatorSubOrder, signer } from "../../lib/stores.js";
  import Button from "../base/Button.svelte";
  import { ContractTransactionResponse, ethers } from "ethers";
  import { onMount, onDestroy } from "svelte";
  
  let _autonomousSwap: AutonomousSwapContract;
  const unsubscribe = autonomousSwap.subscribe((value) => {
    _autonomousSwap = value;
  })

  onDestroy(unsubscribe);


  export let isCreator = false;
  let creatorFinished = false;
  let partnerFinished = false;

  if(isCreator){
    _autonomousSwap.on('StepCompleted' as any, async (orderId, who, newStatus, event) => {
      if (orderId == $mainOrder.orderId && who == $mainOrder.partner){
        if (newStatus == 3){
          console.log(event)
          $partnerState = PartnerState.Completed;
          $creatorState = CreatorState.Completed;
          $mainOrder.finalTransaction = event.transactionHash;

          partnerFinished = true;
          _autonomousSwap.removeAllListeners();
        }
      }
    });
  }


  async function transferFundsToSwap(){
    const transactionResponse: ContractTransactionResponse = await _autonomousSwap.transferFundsToSwap($mainOrder.orderId);
    const transactionReceipt = await transactionResponse.wait();

    if (transactionReceipt.status == 1){
      creatorFinished = true;
    }
  }
</script>


{#if isCreator}
  {#if creatorFinished}
    <p>AGORA É SÓ ESPERAR PAE</p>
  {:else}
    <Button on:click={() => transferFundsToSwap()}>Send Funds</Button>
  {/if}

{:else}
  {#if partnerFinished}
  <p>TERMINOOOUU!!!!!!!!!!</p>
  {:else}
  Awaiting transaction ...
  {/if}
{/if}