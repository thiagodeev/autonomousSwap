<script lang="ts">
  import { ethers, Eip1193Provider } from "ethers";
  import { signer } from "./lib/stores.js";
  import Button from "./components/Button.svelte";
  import Background from "./components/Background.svelte";
  import Card from "./components/Card.svelte";
  import CreateOrderCard from "./components/CreateOrderCard.svelte";

  async function connect(){
    const provider = new ethers.BrowserProvider(window.ethereum);
    // It will prompt user for account connections if it isnt connected
    const signer = await provider.getSigner();
    console.log("Account:", await signer.getAddress());

    return signer;
  }
</script>


  <Background>
    <div class="relative">
      <h1 class="inline-flex font-extrabold text-5xl md:text-6xl bg-clip-text text-transparent bg-gradient-to-r from-slate-200/60 via-slate-200 to-slate-200/60 pb-4 justify-center flex-wrap">
        <span>Autonomous</span>
        <span>Swap</span>
      </h1>
      <div class="max-w-3xl mx-auto mb-8">
        <p class="text-lg text-slate-400">An autonomous/decentralized swap app for tokens transfer between 2 parties without third-party intermediation :D</p>
      </div>
      <div class="inline-flex justify-center space-x-4">
          {#if $signer == null}
            <Button text={'Connect with Metamask'} on:click={async () => $signer = await connect()}></Button>
          
          {:else}
            <div>
                <a class="inline-flex justify-center whitespace-nowrap rounded-lg bg-indigo-500 px-3.5 py-2.5 text-sm font-medium text-white shadow-sm shadow-indigo-950/10 hover:bg-indigo-600 focus-visible:outline-none focus-visible:ring focus-visible:ring-indigo-300 dark:focus-visible:ring-slate-600 transition-colors duration-150 group" href="#0">
                  Create a new Swap Order <span class="tracking-normal text-indigo-300 group-hover:translate-x-0.5 transition-transform duration-150 ease-in-out ml-1">-&gt;</span>
                </a>
            </div>
            <div>
              <a class="inline-flex justify-center whitespace-nowrap rounded-lg bg-slate-700 px-3.5 py-2.5 text-sm font-medium text-white shadow-sm shadow-indigo-950/10 hover:bg-slate-600 focus-visible:outline-none focus-visible:ring focus-visible:ring-indigo-300 dark:focus-visible:ring-slate-600 transition-colors duration-150" href="#0">
                Join an existing swap
              </a>
            </div>
          {/if}
        </div>
    </div>
    <CreateOrderCard />
  </Background>
<!-- #060213 -->