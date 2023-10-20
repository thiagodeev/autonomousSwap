<script lang="ts">
  import { ethers } from "ethers";
  import { autonomousSwap } from "../../lib/stores.js";
  import { onDestroy, onMount } from "svelte";

  
  // onMount(() => {})
  let _autonomousSwap: AutonomousSwapContract;
  const unsubscribe = autonomousSwap.subscribe((value) => {
    _autonomousSwap = value;
  })

	onDestroy(unsubscribe);

  // let event: ethers.ContractEventName = _autonomousSwap.interface.getEventName('StepCompleted');
  _autonomousSwap.on('StepCompleted' as any, (orderId, who, newStatus) => {
    console.log(orderId, who, newStatus);
  });
</script>

<div>
  <h1>OLA, TESTE</h1>
</div>