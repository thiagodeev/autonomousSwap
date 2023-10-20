<script lang="ts">
  import { ethers } from "ethers"; 
  import { signer, mainOrder, creatorSubOrder, partnerSubOrder, autonomousSwap, generalState, creatorState, partnerState } from "../../lib/stores.js";

  export let isCreator;

  let tokenTypes = {
    ERC20: '0xec20ec20',
    ERC721: '0x80ac58cd',
    ERC1155: '0xd9b67a26'
  }

  let creator_tokenType, creator_interfaceID;
  let partner_tokenType, partner_interfaceID;

  if (isCreator){
    [creator_tokenType, creator_interfaceID] = Object.entries(tokenTypes).find((element) => element[1] == $creatorSubOrder.interfaceID);
  } else {
    [partner_tokenType, partner_interfaceID] = Object.entries(tokenTypes).find((element) => element[1] == $partnerSubOrder.interfaceID);
  }

</script>

{#if isCreator}
  <div>
    <p>Token address: {$creatorSubOrder.token}</p>
    <p>Token type: {creator_tokenType}</p>
    {#if creator_interfaceID == tokenTypes.ERC20}
      <p>Quantity: {$creatorSubOrder.quantity}</p>
    {:else if creator_interfaceID == tokenTypes.ERC721}
      <p>Token ID: {$creatorSubOrder.tokenId}</p>
    {:else }
      <p>Token ID: {$creatorSubOrder.tokenId}</p>
      <p>Quantity: {$creatorSubOrder.quantity}</p>
    {/if}
  </div>

{:else }
  <div>
    <!-- <p>Token address: {$partnerSubOrder.token}</p>
    <p>Token type: {partner_tokenType}</p>
    {#if partner_interfaceID == tokenTypes.ERC20}
      <p>Quantity: {$partnerSubOrder.quantity}</p>
    {:else if partner_interfaceID == tokenTypes.ERC721}
      <p>Token ID: {$partnerSubOrder.tokenId}</p>
    {:else }
      <p>Token ID: {$partnerSubOrder.tokenId}</p>
      <p>Quantity: {$partnerSubOrder.quantity}</p>
    {/if} -->
  </div>
{/if}