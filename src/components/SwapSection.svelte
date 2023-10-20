<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, autonomousSwap, generalState, creatorState, partnerState } from "../lib/stores.js";
  import { CreatorState, GeneralState } from "../lib/enums.js";
  import { onMount } from "svelte";
  import Card from "./base/Card.svelte";

</script>

<Card>
  <div>
    <h1 class="mb-10" >{$mainOrder.orderId}</h1>
    <div class="flex justify-around	">
      <slot></slot>
    </div>
  </div>
</Card>