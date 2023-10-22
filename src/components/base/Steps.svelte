<script lang="ts">
  import { steps } from "../../lib/stores.js";

</script>
<div>
  <h2 class="sr-only">Steps</h2>

  <div>
    <ol
      class="grid grid-cols-1 divide-x divide-gray-100 overflow-hidden rounded-lg border border-gray-100 text-sm text-gray-500 sm:grid-cols-3"
    >
      <li class="flex items-center justify-center gap-2 p-4 selected {$steps >= 1 ? 'selected' : ''}">

        <p class="leading-none">
          <strong class="block font-medium"> Order Creation </strong>
          <small class="mt-1"> The first step. </small>
        </p>
      </li>

      <li class="relative flex items-center justify-center gap-2 p-4 {$steps >= 2 ? 'selected' : ''}">
        <span class="absolute -left-2 top-1/2 hidden h-4 w-4 -translate-y-1/2 rotate-45 border border-gray-100 ltr:border-b-0 ltr:border-s-0 ltr:bg-white rtl:border-e-0 rtl:border-t-0 rtl:bg-gray-50 sm:block">
        </span>

        <span class="absolute -right-2 top-1/2 hidden h-4 w-4 -translate-y-1/2 rotate-45 border border-gray-100 ltr:border-b-0 ltr:border-s-0 ltr:bg-gray-50 rtl:border-e-0 rtl:border-t-0 rtl:bg-white sm:block">
        </span>

        <p class="leading-none">
          <strong class="block font-medium"> Allowance </strong>
          <small class="mt-1"> You and your parter must do it. </small>
        </p>
      </li>

      <li class="flex items-center justify-center gap-2 p-4 {$steps >= 3 ? 'selected' : ''}">

        <p class="leading-none">
          <strong class="block font-medium"> Payment </strong>
          <small class="mt-1"> Let them swap! </small>
        </p>
      </li>
<!-- 
      <li class="relative flex items-center justify-center gap-2 p-4 {$steps >= 4 ? 'selected' : ''}">
        <span class="absolute -left-2 top-1/2 hidden h-4 w-4 -translate-y-1/2 rotate-45 border border-gray-100 ltr:border-b-0 ltr:border-s-0 ltr:bg-white rtl:border-e-0 rtl:border-t-0 rtl:bg-gray-50 sm:block">
        </span>

        <p class="leading-none">
          <strong class="block font-medium"> Payment </strong>
          <small class="mt-1"> Show us the money. </small>
        </p>
      </li> -->
    </ol>
  </div>
</div>

<style>
  p{
    color: black
  }
  span {
    background-color: white;
  }
  li {
    background-color: white;
  }
  li.selected {
    background-color: #cfccff;
    color: #6b7280;
  }
</style>