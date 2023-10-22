<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, autonomousSwap, generalState, creatorState, partnerState, mainOrder } from "./lib/stores.js";
  import { CreatorState, GeneralState } from "./lib/enums.js";
  import Background from "./components/Background.svelte";
  import Welcome from "./components/Welcome.svelte";
  import CreateOrderCard from "./components/CreateOrderCard.svelte";
  import { onMount } from "svelte";
  import AutonomousSwapJSON from '../core/artifacts/contracts/AutonomousSwap_flattened.sol/AutonomousSwap.json';
  import JoinsOrder from "./components/JoinsOrder.svelte";
  import CreatorSwap from "./components/CreatorSwap.svelte";
  import ReturnToOrder from "./components/ReturnToOrder.svelte";
  import PartnerSwap from "./components/PartnerSwap.svelte";


  // onMount(async () => {
  //   const rpcLink = 'http://127.0.0.1:8545/';
  //   const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';

  //   const provider = new ethers.JsonRpcProvider(rpcLink);
  //   const _autonomousSwap: AutonomousSwapContract = new ethers.Contract(contractAddress, AutonomousSwapJSON.abi, provider)

  //   $autonomousSwap = _autonomousSwap;
  // })

  onMount(async () => {
    const rpcLink = 'https://ethereum-sepolia.publicnode.com';
    const contractAddress = '0x9a642b656ea04452AbA6e85e11f669a782E5B226';

    const provider = new ethers.JsonRpcProvider(rpcLink);
    const _autonomousSwap: AutonomousSwapContract = new ethers.Contract(contractAddress, AutonomousSwapJSON.abi, provider)

    $autonomousSwap = _autonomousSwap;
  })
  
</script>


  <Background>
    {#if $generalState <= 1}
      <Welcome />
      
    {/if}

    <!-- Firt phase -->
    {#if $generalState == GeneralState.CreatingOrder}
      <CreateOrderCard />
    {/if}

    {#if $generalState == GeneralState.ReturningToOrder}
      <ReturnToOrder />
    {/if}

    {#if $generalState == GeneralState.JoiningOrder}
      <JoinsOrder/>
    {/if}
    
    <!-- Second phase -->
    {#if $mainOrder != null}
      {#if $mainOrder.isCreator}
        <CreatorSwap/>
        {:else}
        <PartnerSwap/>
      {/if}
    {/if}

  </Background>