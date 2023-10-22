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
  import Button from "./base/Button.svelte";
  import FinalStep from "./creator/FinalStep.svelte";

  
</script>

<SwapSection>
  <!-- {#if $mainOrder.finalTransaction == null} -->
  {#if !($partnerState == PartnerState.Completed && $creatorState == CreatorState.Completed)}
    <div>
      <h1>CREATOR: {$mainOrder.creator}</h1>
        {#if $creatorState == CreatorState.WaitingForPartnerJoin}
          <CreationStep isCreator={true}/>
        {:else if $creatorState == CreatorState.AllowingAutonomousSwap || $creatorState == CreatorState.WaitingPartnerAllowance}
          <AllowanceStep isCreator={true}/>
        {:else if $creatorState == CreatorState.SendingTokens}
          <FinalStep isCreator={true} />
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
          <AllowanceStep />
          {#if $creatorState == CreatorState.WaitingPartnerAllowance && $partnerState == PartnerState.WaitingCreatorAllowance}
            <Button on:click={() => {$creatorState = CreatorState.SendingTokens; $partnerState = PartnerState.WaitingCreatorsFunding}}>Next Step</Button>
          {/if}
        {:else if $partnerState == PartnerState.WaitingCreatorsFunding}
          <FinalStep />
        {:else if $partnerState == PartnerState.Completed}
          <p>teste6</p>
        {/if}
    </div>

  {:else}
    <div>
      <h1 class="text-6xl">PARABÉNS, DEU CERTOOO!!</h1>
      <h1 class="text-4xl">{$mainOrder.finalTransaction}</h1>
    </div>
  {/if}
</SwapSection>