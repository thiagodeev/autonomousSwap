<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, creatorSubOrder, autonomousSwap, generalState, creatorState, partnerState } from "../../lib/stores.js";

  let tokenTypes = {
    ERC20: '0xec20ec20',
    ERC721: '0x80ac58cd',
    ERC1155: '0xd9b67a26'
  }
  let [tokenType, interfaceID] = Object.entries(tokenTypes).find((element) => element[1] == $creatorSubOrder.interfaceID);

</script>

{#if $mainOrder.isCreator}
  <div>
    <p>Token address: {$creatorSubOrder.token}</p>
    <p>Token type: {tokenType}</p>
    {#if interfaceID == tokenTypes.ERC20}
      <p>Quantity: {$creatorSubOrder.quantity}</p>
    {:else if interfaceID == tokenTypes.ERC721}
      <p>Token ID: {$creatorSubOrder.tokenId}</p>
    {:else }
      <p>Token ID: {$creatorSubOrder.tokenId}</p>
      <p>Quantity: {$creatorSubOrder.quantity}</p>
    {/if}
  </div>

{:else }
<p>CALMA AE MEU PATÃO</p>
{/if}