import './hmr';
import './main.css';
import App from './App.svelte'
import { ethers } from "ethers";
import { AutonomousSwap } from '../core/typechain-types/contracts/AutonomousSwap_flattened.sol'

declare global {
  interface Window{
    ethereum?:ethers.Eip1193Provider
  }

  type AutonomousSwapContract = ethers.Contract | AutonomousSwap;
}



const app = new App({
  target: document.body
})

export default app
