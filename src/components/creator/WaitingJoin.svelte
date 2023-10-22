<script lang="ts">
  import { PartnerState } from "../../lib/enums.js";
  import { autonomousSwap, mainOrder, partnerSubOrder, partnerState } from "../../lib/stores.js";
  import { onDestroy } from "svelte";
  import Loader from "../base/Loader.svelte";
  
  let _autonomousSwap: AutonomousSwapContract;
  const unsubscribe = autonomousSwap.subscribe((value) => {
    _autonomousSwap = value;
  })

	onDestroy(unsubscribe);

  
  _autonomousSwap.on('StepCompleted' as any, async (orderId, who, newStatus, event) => {
    if (orderId == $mainOrder.orderId && who != $mainOrder.creator){
      let result = await _autonomousSwap.getSubOrderByUser(who, orderId);

      partnerSubOrder.update(() => {
        return ({
          token: result.token,
          interfaceID: result.interfaceID,
          tokenId: result.tokenId,
          quantity: result.quantity,
          individualStatus: newStatus
        })
      })

      _autonomousSwap.removeAllListeners();
      $partnerState = PartnerState.WaitingFirstConfirmation;
      $mainOrder.partner = who;
    }
  });
</script>

<div class="relative flex flex-col">
  <Loader>
    <div>
      <p>Waiting the </p>
      <slot></slot>
    </div>
  </Loader>
</div>