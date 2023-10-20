import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import 'dotenv/config'

const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    mantleTest: {
      url: "https://rpc.testnet.mantle.xyz", // testnet
      accounts: [process.env.ACCOUNT_PRIVATE_KEY!]
    }
},
};

export default config;
