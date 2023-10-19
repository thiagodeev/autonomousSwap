<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, autonomousSwap, generalState, creatorState, partnerState, mainOrder } from "./lib/stores.js";
  import { CreatorState, GeneralState } from "./lib/enums.js";
  import Background from "./components/Background.svelte";
  import Welcome from "./components/Welcome.svelte";
  import CreateOrderCard from "./components/CreateOrderCard.svelte";
  import { onMount } from "svelte";
  import AutonomousSwapJSON from '../core/artifacts/contracts/AutonomousSwap.sol/AutonomousSwap.json';
  import SwapSection from "./components/SwapSection.svelte";
  import JoinsOrder from "./components/JoinsOrder.svelte";


  onMount(async () => {
    const rpcLink = 'http://127.0.0.1:8545/';
    const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';

    const provider = new ethers.JsonRpcProvider(rpcLink);
    const _autonomousSwap: AutonomousSwapContract = new ethers.Contract(contractAddress, AutonomousSwapJSON.abi, provider)

    $autonomousSwap = _autonomousSwap;
  })

  
</script>


  <Background>
    <Welcome />
    {#if $generalState == GeneralState.CreatingOrder}
      <CreateOrderCard />
    {/if}

    {#if $generalState == GeneralState.JoiningOrder}
      <JoinsOrder/>
    {/if}
    
    {#if $mainOrder != null}
      <SwapSection/>
    {/if}

  </Background>