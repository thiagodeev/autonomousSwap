import { ethers } from "hardhat";

async function main() {
  const AutonomousSwap = await ethers.deployContract("contracts/AutonomousSwap_flattened.sol:AutonomousSwap", { gasLimit: 0x1000000});

  await AutonomousSwap.waitForDeployment();

  console.log("Contract deployed at ", await AutonomousSwap.getAddress());
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
