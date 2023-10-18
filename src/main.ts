import './hmr';
import './main.css';
import App from './App.svelte'
import { ethers } from "ethers";

declare global {
  interface Window{
    ethereum?:ethers.Eip1193Provider
  }
}



const app = new App({
  target: document.body
})

export default app
