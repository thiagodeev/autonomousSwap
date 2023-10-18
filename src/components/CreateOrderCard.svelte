<script>
  import { onMount } from "svelte";
  import Card from "./base/Card.svelte";
  import ChooseToken from "./ChooseToken.svelte";

  // onMount(() => {
  //   initTE({ Select, Input });
  // })

  // export let orderInfo;
</script>

<Card>
  <h1 class="text-4xl font-bold text-slate-900">Order creation</h1>
  
  <ChooseToken />
</Card>