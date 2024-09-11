import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    Holesky: {
      url: process.env.NETWORKS_URL,
      accounts: [process.env.PRIVATE_KEY || ""],
      chainId: 17000,
    },
  },
  solidity: "0.8.7",
};

export default config;
