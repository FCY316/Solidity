const { ethers } = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

const deploy = async () => {
  // HTTP://127.0.0.1:7545
  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
  const abi = fs.readFileSync("./index_sol_Index.json", "utf8");
  const binary = fs.readFileSync("./index_sol_Index.bin", "utf8");
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("正在部署中，请稍等...");
  const contract = await contractFactory.deploy();
  // 查询合约部署信息
  await contract.deploymentTransaction().wait();

  // 调用合约retrieve函数 获取合约中的favoiteNumber参数
  const favoiteNumber = await contract.retrieve();
  console.log("favoiteNumber", favoiteNumber.toString());
  const tx = await contract.store("7");
  await tx.wait();
  const newFavoiteNumber = await contract.retrieve();
  console.log("newFavoiteNumber", newFavoiteNumber.toString());
};

deploy().then(
  () => {
    console.log("合约部署成功");
  },
  (error) => {
    console.log("合约部署失败", error);
  }
);

/*
  通过 dotenv 插件 将 私钥 rpc 存在 .env 文件中 ，但是还是可以把 .env 推到 git 上面 ，如果不想的话，你可以对git动手脚
 */
