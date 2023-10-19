<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, autonomousSwap, generalState, creatorState, partnerState } from "../lib/stores.js";
  import { CreatorState, GeneralState } from "../lib/enums.js";
  import { onMount } from "svelte";
  import Card from "./base/Card.svelte";
  import CreatorSection from "./CreatorSection.svelte";
  import PartnerSection from "./PartnerSection.svelte";


  onMount(async () => {

  })

  
</script>

<Card>
  <div>
    <h1>{$mainOrder.orderId}</h1>
    <div class="flex justify-around	">
      <CreatorSection/>
      <PartnerSection/>
    </div>
  </div>
</Card>