<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, creatorSubOrder, autonomousSwap, generalState, creatorState, partnerState } from "../lib/stores.js";
  import { CreatorState, PartnerState } from "../lib/enums.js";
  import CreationStep from "./creator/CreationStep.svelte";
  import SwapSection from "./SwapSection.svelte";
  import WaitingJoin from "./creator/WaitingJoin.svelte";
  import { onMount, onDestroy } from "svelte";
  import AllowanceStep from "./creator/AllowanceStep.svelte";
  import Button from "./base/Button.svelte";
  import FinalStep from "./creator/FinalStep.svelte";
  import CancelButton from "./creator/CancelButton.svelte";

  
</script>

<SwapSection>
  <!-- {#if $mainOrder.finalTransaction == null} -->
  {#if !($partnerState == PartnerState.Completed && $creatorState == CreatorState.Completed)}
    <div>
      <h1 class="pb-5 relative"> <CancelButton/> <strong class="ml-1">Creator:</strong> {$mainOrder.creator}</h1>
      <hr class="mb-5 h-0.5 bg-black">
      {#if $creatorState == CreatorState.WaitingForPartnerJoin}
          <CreationStep isCreator={true}/>
        {:else if $creatorState == CreatorState.AllowingAutonomousSwap || $creatorState == CreatorState.WaitingPartnerAllowance}
          <AllowanceStep isCreator={true}/>
        {:else if $creatorState == CreatorState.SendingTokens}
          <FinalStep isCreator={true} />
        {:else if $creatorState == CreatorState.WaitingPartnersTransfer}
        <p>Finished! Now, just await for the partner.</p>
        {:else if $creatorState == CreatorState.Completed}
        <p>Finished!</p>
        {/if}
    </div>

    <div>
      <h1 class="pb-5"><strong>Partner:</strong> {($mainOrder.partner != '0x0000000000000000000000000000000000000000' && $mainOrder.partner) ? $mainOrder.partner : 'waiting...'}</h1>
      <hr class="mb-5 h-0.5 bg-black">
      {#if $partnerState == null}
          <WaitingJoin>partner.</WaitingJoin>
        {:else if $partnerState == PartnerState.WaitingFirstConfirmation}
          <CreationStep on:click={() => {$creatorState = CreatorState.AllowingAutonomousSwap; $partnerState = PartnerState.AllowingAutonomousSwap}}/>
        {:else if $partnerState == PartnerState.AllowingAutonomousSwap || $partnerState == PartnerState.WaitingCreatorAllowance}
          <AllowanceStep />
          {#if $creatorState == CreatorState.WaitingPartnerAllowance && $partnerState == PartnerState.WaitingCreatorAllowance}
            <Button isStep={true} on:click={() => {$creatorState = CreatorState.SendingTokens; $partnerState = PartnerState.WaitingCreatorsFunding}}>Next Step</Button>
          {/if}
        {:else if $partnerState == PartnerState.WaitingCreatorsFunding}
          <FinalStep />
        {:else if $partnerState == PartnerState.Completed}
          <p>Finished!</p>
        {/if}
    </div>

  {:else}
    <div class="col-span-2 ">
      <h1 class="text-6xl">Order Completed!!!</h1>
    </div>
  {/if}
</SwapSection>