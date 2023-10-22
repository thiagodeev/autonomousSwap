<script lang="ts">
  import { creatorSubOrder, partnerSubOrder } from "../../lib/stores.js";
  import Button from "../base/Button.svelte";
  export let isCreator = false;

  let tokenTypes = {
    ERC20: '0xec20ec20',
    ERC721: '0x80ac58cd',
    ERC1155: '0xd9b67a26'
  }

  let tokenType, interfaceID;
  $: _subOrder = {
    token: '',
    quantity: '',
    tokenId: ''
  };
  if (isCreator) {
    [tokenType, interfaceID] = Object.entries(tokenTypes).find((element) => element[1] == $creatorSubOrder.interfaceID);
    _subOrder = {
      token: $creatorSubOrder.token,
      quantity: $creatorSubOrder.quantity,
      tokenId: $creatorSubOrder.tokenId
    }

    console.log(_subOrder)
  } else {
    [tokenType, interfaceID] = Object.entries(tokenTypes).find((element) => element[1] == $partnerSubOrder.interfaceID);
    _subOrder = {
      token: $partnerSubOrder.token,
      quantity: $partnerSubOrder.quantity,
      tokenId: $partnerSubOrder.tokenId
    }
    console.log(_subOrder)
  }


</script>

<div>
  <p>Token address: {_subOrder.token}</p>
  <p>Token type: {tokenType}</p>
  {#if interfaceID == tokenTypes.ERC20}
    <p>Quantity: {_subOrder.quantity}</p>
  {:else if interfaceID == tokenTypes.ERC721}
    <p>Token ID: {_subOrder.tokenId}</p>
  {:else }
    <p>Token ID: {_subOrder.tokenId}</p>
    <p>Quantity: {_subOrder.quantity}</p>
  {/if}
</div>

{#if !isCreator}
  <Button on:click>Next Step</Button>
{/if}
