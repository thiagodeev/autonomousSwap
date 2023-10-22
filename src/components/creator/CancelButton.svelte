<script lang="ts">
  import Button from "../base/Button.svelte";
  import { autonomousSwap, mainOrder, partnerSubOrder, creatorState, partnerState, creatorSubOrder, signer } from "../../lib/stores.js";
  import { onDestroy } from "svelte";
  import { ContractTransactionResponse } from "ethers";

  let cancelled = false

  let _autonomousSwap: AutonomousSwapContract;
  const unsubscribe = autonomousSwap.subscribe((value) => {
    _autonomousSwap = value;
  })

  onDestroy(unsubscribe);

  async function cancelOrder(){
    const transactionResponse: ContractTransactionResponse = await _autonomousSwap.cancelOrder($mainOrder.orderId);
    const transactionReceipt = await transactionResponse.wait();

    if (transactionReceipt.status == 1){
      cancelled = true;
    }
  }
</script>

<div class="absolute -top-[150%]">
  <Button on:click={cancelOrder}>
    {cancelled ? 'Cancelled!!' : 'Cancel'}
  </Button>
</div>