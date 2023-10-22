<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, autonomousSwap, generalState, creatorState, partnerState, steps } from "../lib/stores.js";
  import { CreatorState, PartnerState } from "../lib/enums.js";
  import { onMount } from "svelte";
  import Card from "./base/Card.svelte";
  import Steps from "./base/Steps.svelte";


  $: {
    if ($creatorState == CreatorState.WaitingForPartnerJoin
    || $partnerState == PartnerState.WaitingFirstConfirmation){
      $steps = 1;
    } else
    if ($creatorState == CreatorState.AllowingAutonomousSwap
    || $partnerState == PartnerState.AllowingAutonomousSwap) {
      $steps = 2;
    } else
    if ($creatorState == CreatorState.SendingTokens
    || $partnerState == PartnerState.WaitingCreatorsFunding) {
      $steps = 3;
    }
  }
</script>
{#if !($partnerState == PartnerState.Completed && $creatorState == CreatorState.Completed)}
<Steps/>
  
{/if}

<Card>
  <div>
    <h1 class="mb-10 font-bold text-lg" >Order Id: {$mainOrder.orderId}</h1>
    <div class="grid grid-cols-1 sm:grid-cols-2">
      <slot></slot>
    </div>
  </div>
</Card>