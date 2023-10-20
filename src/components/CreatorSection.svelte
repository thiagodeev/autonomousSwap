<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, creatorSubOrder, autonomousSwap, generalState, creatorState, partnerState } from "../lib/stores.js";
  import { CreatorState } from "../lib/enums.js";
  import CreationStep from "./steps/CreationStep.svelte";
</script>

<div>
  <h1>CREATOR: {$mainOrder.creator}</h1>
  {#if $mainOrder.isCreator}
    {#if $creatorState == CreatorState.WaitingForPartnerJoin}
      <CreationStep isCreator={true}/>
    {:else if $creatorState == CreatorState.AllowingAutonomousSwap}
      <p>teste2</p>
    {:else if $creatorState == CreatorState.WaitingPartnerAllowance}
      <p>teste3</p>
    {:else if $creatorState == CreatorState.SendingTokens}
      <p>teste4</p>
    {:else if $creatorState == CreatorState.WaitingPartnersTransfer}
      <p>teste5</p>
    {:else if $creatorState == CreatorState.Completed}
      <p>teste6</p>
    {/if}
    
  {:else}
    <p>WAITING</p>
  {/if}
</div>