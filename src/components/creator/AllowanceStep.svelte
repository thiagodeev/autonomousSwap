<script lang="ts">
  import { CreatorState, PartnerState } from "../../lib/enums.js";
  import { autonomousSwap, mainOrder, partnerSubOrder, creatorState, partnerState, creatorSubOrder, signer } from "../../lib/stores.js";
  import Button from "../base/Button.svelte";
  import { IERC1155, IERC721, IERC20} from '../../../core/typechain-types/index.js';
  import * as IERC20json from '../../assets/IERC20.json';
  import * as IERC721json from '../../assets/IERC721.json';
  import * as IERC1155json from '../../assets/IERC1155.json';
  import { ethers } from "ethers";
  import { onMount } from "svelte";
  
  
  export let isCreator = false;
  let creatorAllowance = false;
  let partnerAllowance = false;
  
  let tokenTypes = {
    ERC20: '0xec20ec20',
    ERC721: '0x80ac58cd',
    ERC1155: '0xd9b67a26'
  };
  let interfaceID;
  let interval1;
  let interval2;

  
  if (isCreator){
    interfaceID = $creatorSubOrder.interfaceID;
    
    interval1 = setInterval( async () => {
      let response = await isAllowed($creatorSubOrder.token, $mainOrder.creator, interfaceID, $creatorSubOrder.quantity, $creatorSubOrder.tokenId)
      if (response) creatorAllowance = true;
      console.log(partnerAllowance)
    }, 1000);
    
  } else {
    interfaceID = $partnerSubOrder.interfaceID;
    
    interval2 = setInterval( async () => {
      let response = await isAllowed($partnerSubOrder.token, $mainOrder.partner, interfaceID, $partnerSubOrder.quantity, $partnerSubOrder.tokenId)
      if (response) partnerAllowance = true;
      console.log(partnerAllowance)
    }, 1000);
  }
  
  if (partnerAllowance) {clearInterval(interval1); $creatorState == CreatorState.WaitingPartnerAllowance}
  if (creatorAllowance) {clearInterval(interval2); $partnerState == PartnerState.WaitingCreatorAllowance}

  // onMount(async ()=>{
//   creatorAllowance = await isAllowed($creatorSubOrder.token, interfaceID, $creatorSubOrder.quantity, $creatorSubOrder.tokenId)
//   console.log(creatorAllowance)
// })
  async function isAllowed(tokenAddress, owner, interfaceID, quantity, tokenId):Promise<boolean> {
    console.log(tokenAddress, interfaceID, quantity, tokenId)
    let contract: IERC20 & IERC721 & IERC1155 & ethers.BaseContract;
    let autonomousSwapAddress = await $autonomousSwap.getAddress();
    let result;

    if (interfaceID == tokenTypes.ERC20){
        contract = new ethers.Contract(tokenAddress, IERC20json.abi, $signer) as IERC20 | any;
        result = await contract.allowance(owner, autonomousSwapAddress);
        console.log(result)

        if (result >= quantity) {
          return true;
        } else {
          return false;
        }
      } else 
      if (interfaceID == tokenTypes.ERC721){
        contract = new ethers.Contract(tokenAddress, IERC721json.abi, $signer) as IERC20 | any;
        result = await contract.getApproved(tokenId);
        console.log(result)
        if (result == autonomousSwapAddress) {
          return true;
        } else {
          return false;
        }
      } else {
        contract = new ethers.Contract(tokenAddress, IERC1155json.abi, $signer) as IERC20 | any;
        result = await contract.isApprovedForAll(owner, autonomousSwapAddress);
        console.log(result)
        if (result) {
          return true;
        } else {
          return false;
        }
      }
  }

  function getContract(address, interfaceID,): IERC20 & IERC721 & IERC1155 & ethers.BaseContract {
    let contract: IERC20 & IERC721 & IERC1155 & ethers.BaseContract;

    if (interfaceID == tokenTypes.ERC20){
      return contract = new ethers.Contract(address, IERC20json.abi, $signer) as IERC20 | any;
    } else 
    if (interfaceID == tokenTypes.ERC721){
      return contract = new ethers.Contract(address, IERC721json.abi, $signer) as IERC721 | any;
    } else {
      return contract = new ethers.Contract(address, IERC1155json.abi, $signer) as IERC1155 | any;
    }
  }

  async function requestAllowance(tokenAddress){
    let autonomousSwapAddress = await $autonomousSwap.getAddress();
    let transactionResponse;

    let contract = getContract(tokenAddress, interfaceID);
    if (interfaceID == tokenTypes.ERC20){
      transactionResponse = await contract.approve(autonomousSwapAddress, $creatorSubOrder.quantity);
    } else 
    if (interfaceID == tokenTypes.ERC721){
      transactionResponse = await contract.approve(autonomousSwapAddress, $creatorSubOrder.tokenId);
    } else {
      transactionResponse = await contract.setApprovalForAll(autonomousSwapAddress, true);
    }

    const transactionReceipt = await transactionResponse.wait();

    if (transactionReceipt.status == 1){
      creatorAllowance = true;
    }
  }


</script>


{#if isCreator}
  {#if creatorAllowance}
    <p>APROVADO CARAMBA</p>
  {:else}
    <Button on:click={() => requestAllowance($creatorSubOrder.token)}>Give Allowance</Button>
  {/if}

{:else}
  {#if partnerAllowance}
  <p>APROVADO CARAMBA</p>
    {#if creatorAllowance && partnerAllowance}
      <Button on:click>Next Step</Button>
    {/if}
  {:else}
  Awaiting Allowance ...
  {/if}
{/if}