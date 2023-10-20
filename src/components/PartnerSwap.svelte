<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, creatorSubOrder, autonomousSwap, generalState, partnerState } from "../lib/stores.js";
  import { PartnerState } from "../lib/enums.js";
  import CreationStep from "./partner/CreationStep.svelte";
</script>

<div>
  <h1>PARTNER: {$mainOrder.partner}</h1>
  {#if !$mainOrder.isCreator}
    {#if $partnerState == PartnerState.WaitingFirstConfirmation}
      <CreationStep/>
    {:else if $partnerState == PartnerState.AllowingAutonomousSwap}
      <p>teste2</p>
    {:else if $partnerState == PartnerState.WaitingCreatorAllowance}
      <p>teste3</p>
    {:else if $partnerState == PartnerState.WaitingCreatorsFunding}
      <p>teste4</p>
    {:else if $partnerState == PartnerState.SendingTokens}
      <p>teste5</p>
    {:else if $partnerState == PartnerState.Completed}
      <p>teste6</p>
    {/if}
    
  {:else}
    <p>WAITING</p>
  {/if}
</div>