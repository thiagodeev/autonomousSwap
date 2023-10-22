<script>

  export let isJoining = false;

  let tokenType;
  let tokenTypes = {
    ERC20: '0xec20ec20',
    ERC721: '0x80ac58cd',
    ERC1155: '0xd9b67a26'
  }

  let subOrder = {
    token: 0,
    interfaceID: 0,
    tokenId: 0,
    quantity: 0,
    individualStatus: 0,
  };

</script>


<div>
  <form on:submit|preventDefault>
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
              name="quantityInput"
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

      {#if isJoining}
      <!-- OrderId -->
      <div class="relative mb-3">
        <label
        for="orderIdnumber"
        class="relative block overflow-hidden rounded-md border border-gray-200 px-3 pt-3 shadow-sm focus-within:border-blue-600 focus-within:ring-1 focus-within:ring-blue-600"
        >
          <input
            type="text"
            id="orderIdnumber"
            required
            class="peer h-8 w-full border-none bg-transparent p-0 placeholder-transparent focus:border-transparent focus:outline-none focus:ring-0 sm:text-sm"
            placeholder="Order ID"
          />

          <span
            class="absolute start-3 top-3 -translate-y-1/2 text-xs text-gray-700 transition-all peer-placeholder-shown:top-1/2 peer-placeholder-shown:text-sm peer-focus:top-3 peer-focus:text-xs"
          >
            Order ID
          </span>
        </label>
      </div>

    {/if}

    </div>

    <!--Submit button-->
    <button
      type="submit"
      class="inline-block rounded border border-indigo-600 bg-indigo-600 px-12 py-3 text-sm font-medium text-white hover:bg-transparent hover:text-indigo-600 focus:outline-none focus:ring active:text-indigo-500">
        Submit
    </button>
  </form>
</div>