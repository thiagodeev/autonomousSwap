<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, creatorSubOrder, autonomousSwap, generalState, creatorState, partnerState } from "../lib/stores.js";
  import { CreatorState, PartnerState } from "../lib/enums.js";
  import CreationStep from "./creator/CreationStep.svelte";
  import Teste from "./creator/Teste.svelte";
  import SwapSection from "./SwapSection.svelte";
  import WaitingJoin from "./creator/WaitingJoin.svelte";
  import { onMount, onDestroy } from "svelte";
  import AllowanceStep from "./creator/AllowanceStep.svelte";

  
</script>

<SwapSection>
  <div>
    <h1>CREATOR: {$mainOrder.creator}</h1>
      {#if $creatorState == CreatorState.WaitingForPartnerJoin}
        <CreationStep isCreator={true}/>
      {:else if $creatorState == CreatorState.AllowingAutonomousSwap || $creatorState == CreatorState.WaitingPartnerAllowance}
        <AllowanceStep isCreator={true}/>
      {:else if $creatorState == CreatorState.SendingTokens}
        <p>teste4</p>
      {:else if $creatorState == CreatorState.WaitingPartnersTransfer}
        <p>teste5d</p>
      {:else if $creatorState == CreatorState.Completed}
        <p>teste6</p>
      {/if}
  </div>

  <div>
    <h1>PARTNER: {$mainOrder.partner ? $mainOrder.partner : 'waiting...'}</h1>
      {#if $partnerState == null}
        <WaitingJoin>PARTNER</WaitingJoin>
      {:else if $partnerState == PartnerState.WaitingFirstConfirmation}
        <CreationStep on:click={() => {$creatorState = CreatorState.AllowingAutonomousSwap; $partnerState = PartnerState.AllowingAutonomousSwap}}/>
      {:else if $partnerState == PartnerState.AllowingAutonomousSwap || $partnerState == PartnerState.WaitingCreatorAllowance}
        <AllowanceStep on:click={() => {$creatorState = CreatorState.SendingTokens; $partnerState = PartnerState.WaitingCreatorsFunding}}/>
      {:else if $partnerState == PartnerState.WaitingCreatorsFunding}
        <p>teste4</p>
      {:else if $partnerState == PartnerState.SendingTokens}
        <p>teste5</p>
      {:else if $partnerState == PartnerState.Completed}
        <p>teste6</p>
      {/if}
  </div>
</SwapSection>