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
  如果你觉得还是不安全可以使用终端命令输入私钥和rpc 然后在运行
  PRIVATE_KEY=0xb7df22ee2cb17c9d7e238ffa7af1e398f16da04ea47b2d34435a383a08bcf096 RPC_URL=http://127.0.0.1:7545 node deploy.js 
*/
