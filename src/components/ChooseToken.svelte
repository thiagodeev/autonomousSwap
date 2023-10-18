<script>
  import { onMount } from "svelte";

  let tokenType;

  let tokenTypes = {
    ERC20: '0xec20ec20',
    ERC721: '0x80ac58cd',
    ERC1155: '0xd9b67a26'
  }

  $: console.log(tokenType)
  // export let orderInfo;
</script>


<div>
  <form>
    <div class="relative mb-12" >
      <select bind:value={tokenType}>
        <option value={tokenTypes.ERC20}>ERC20</option>
        <option value={tokenTypes.ERC721}>ERC721</option>
        <option value={tokenTypes.ERC1155}>ERC1155</option>
      </select>

      <!-- Contract Address -->
      <div class="relative mb-3">
        <label
        for="contractAddressId"
        class="relative block overflow-hidden rounded-md border border-gray-200 px-3 pt-3 shadow-sm focus-within:border-blue-600 focus-within:ring-1 focus-within:ring-blue-600"
        >
          <input
            type="text"
            id="contractAddressId"
            required
            class="peer h-8 w-full border-none bg-transparent p-0 placeholder-transparent focus:border-transparent focus:outline-none focus:ring-0 sm:text-sm"
            placeholder="Contract address"
          />

          <span
            class="absolute start-3 top-3 -translate-y-1/2 text-xs text-gray-700 transition-all peer-placeholder-shown:top-1/2 peer-placeholder-shown:text-sm peer-focus:top-3 peer-focus:text-xs"
          >
            Contract address
          </span>
        </label>
      </div>

      {#if tokenType == tokenTypes.ERC721 || tokenType == tokenTypes.ERC1155}
        <!-- TokenId -->
        <div class="relative mb-3">
          <label
          for="tokenIdInput"
          class="relative block overflow-hidden rounded-md border border-gray-200 px-3 pt-3 shadow-sm focus-within:border-blue-600 focus-within:ring-1 focus-within:ring-blue-600"
          >
            <input
              type="text"
              id="tokenIdInput"
              required
              class="peer h-8 w-full border-none bg-transparent p-0 placeholder-transparent focus:border-transparent focus:outline-none focus:ring-0 sm:text-sm"
              placeholder="Token ID"
            />
  
            <span
              class="absolute start-3 top-3 -translate-y-1/2 text-xs text-gray-700 transition-all peer-placeholder-shown:top-1/2 peer-placeholder-shown:text-sm peer-focus:top-3 peer-focus:text-xs"
            >
              Token ID
            </span>
          </label>
        </div>
  
      {/if}

      {#if tokenType == tokenTypes.ERC20 || tokenType == tokenTypes.ERC1155}
        <!-- Quantity -->
        <div class="relative mb-3">
          <label
          for="quantityInput"
          class="relative block overflow-hidden rounded-md border border-gray-200 px-3 pt-3 shadow-sm focus-within:border-blue-600 focus-within:ring-1 focus-within:ring-blue-600"
          >
            <input
              type="text"
              id="quantityInput"
              required
              class="peer h-8 w-full border-none bg-transparent p-0 placeholder-transparent focus:border-transparent focus:outline-none focus:ring-0 sm:text-sm"
              placeholder="Quantity"
            />
  
            <span
              class="absolute start-3 top-3 -translate-y-1/2 text-xs text-gray-700 transition-all peer-placeholder-shown:top-1/2 peer-placeholder-shown:text-sm peer-focus:top-3 peer-focus:text-xs"
            >
              Quantity
            </span>
          </label>
        </div>
  
      {/if}

    </div>

    <!--Submit button-->
    <button
      on:submit|preventDefault
      type="submit"
      class="inline-block rounded bg-primary px-6 pb-2 pt-2.5 text-xs font-medium uppercase leading-normal text-white shadow-[0_4px_9px_-4px_#3b71ca] transition duration-150 ease-in-out hover:bg-primary-600 hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:bg-primary-600 focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] focus:outline-none focus:ring-0 active:bg-primary-700 active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.3),0_4px_18px_0_rgba(59,113,202,0.2)] dark:shadow-[0_4px_9px_-4px_rgba(59,113,202,0.5)] dark:hover:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:focus:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)] dark:active:shadow-[0_8px_9px_-4px_rgba(59,113,202,0.2),0_4px_18px_0_rgba(59,113,202,0.1)]">
      Submit
    </button>
  </form>
</div>