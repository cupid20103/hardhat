/**
 * @type import('hardhat/config').HardhatUserConfig
 */

require("dotenv").config();
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");

const {
  MAIN_API_URL,
  ROPSTEN_API_URL,
  RINKEBY_API_URL,
  PRIVATE_KEY,
  ETHERSCAN_API_KEY,
} = process.env;

module.exports = {
  solidity: {
    version: "0.7.3",
    settings: {
      optimizer: {
        enabled: true,
      },
    },
  },
  defaultNetwork: "mainnet",
  networks: {
    hardhat: {},
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    mainnet: {
      url: MAIN_API_URL,
      chainId: 1,
      gasPrice: 1000000000,
      accounts: [`0x${PRIVATE_KEY}`],
    },
    ropsten: {
      url: ROPSTEN_API_URL,
      chainId: 3,
      gasPrice: 20000000000,
      accounts: [`0x${PRIVATE_KEY}`],
    },
    rinkeby: {
      url: RINKEBY_API_URL,
      chainId: 4,
      gasPrice: 20000000000,
      accounts: [`0x${PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  },
};
