<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, creatorSubOrder, autonomousSwap, generalState, creatorState, partnerState } from "../lib/stores.js";
  import FirstStep from "./steps/FirstStep.svelte";
</script>

<div>
  <h1>CREATOR SECTION</h1>
  {#if $mainOrder.isCreator}
    <!-- <p>{$creatorSubOrder.token}</p>
    <p>{$creatorSubOrder.interfaceID}</p>
    <p>{$creatorSubOrder.tokenId}</p>
    <p>{$creatorSubOrder.quantity}</p>
    <p>{$creatorSubOrder.individualStatus}</p>
    <p></p> -->
    <FirstStep/>
    
  {:else}
    <p>WAITING</p>
  {/if}
</div>