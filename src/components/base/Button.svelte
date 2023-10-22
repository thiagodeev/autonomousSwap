<script>
  export let isStep = false;
</script>

<!-- svelte-ignore a11y-click-events-have-key-events -->
<div on:click >
  <a class="inline-flex justify-center whitespace-nowrap rounded-lg bg-indigo-500 px-3.5 py-2.5 text-sm font-medium text-white shadow-sm shadow-indigo-950/10 hover:bg-indigo-600 focus-visible:outline-none focus-visible:ring focus-visible:ring-indigo-300 dark:focus-visible:ring-slate-600 transition-colors duration-150 group
  {isStep ? "relative -left-[50%] mt-3" : ""}
  " href="#0">
    <slot></slot>
  </a>
</div>