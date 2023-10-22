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
  let _subOrder;

  $: {
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
  }


</script>
<div class="flow-root">

  <dl class="-my-3 divide-y divide-gray-100 text-sm">
    <div class="grid grid-cols-1 gap-1 py-3 sm:grid-cols-3 sm:gap-4">
      <dt class="font-medium text-gray-900">Token address:</dt>
      <dd class="text-gray-700 sm:col-span-2">{_subOrder.token}</dd>
    </div>
    <div class="grid grid-cols-1 gap-1 py-3 sm:grid-cols-3 sm:gap-4">
      <dt class="font-medium text-gray-900">Token type:</dt>
      <dd class="text-gray-700 sm:col-span-2">{tokenType}</dd>
    </div>

    {#if interfaceID == tokenTypes.ERC20}
    <div class="grid grid-cols-1 gap-1 py-3 sm:grid-cols-3 sm:gap-4">
      <dt class="font-medium text-gray-900">Quantity:</dt>
      <dd class="text-gray-700 sm:col-span-2">{_subOrder.quantity}</dd>
    </div>
    {:else if interfaceID == tokenTypes.ERC721}
    <div class="grid grid-cols-1 gap-1 py-3 sm:grid-cols-3 sm:gap-4">
      <dt class="font-medium text-gray-900">Token ID:</dt>
      <dd class="text-gray-700 sm:col-span-2">{_subOrder.tokenId}</dd>
    </div>
    {:else }
    <div class="grid grid-cols-1 gap-1 py-3 sm:grid-cols-3 sm:gap-4">
      <dt class="font-medium text-gray-900">Token ID:</dt>
      <dd class="text-gray-700 sm:col-span-2">{_subOrder.tokenId}</dd>
    </div>
    <div class="grid grid-cols-1 gap-1 py-3 sm:grid-cols-3 sm:gap-4">
      <dt class="font-medium text-gray-900">Quantity:</dt>
      <dd class="text-gray-700 sm:col-span-2">{_subOrder.quantity}</dd>
    </div>
    {/if}
  </dl>
</div>

{#if !isCreator}
  <Button isStep={true} on:click>Next Step</Button>
{/if}
