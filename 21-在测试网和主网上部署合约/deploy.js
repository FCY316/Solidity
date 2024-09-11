const { ethers } = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

const deploy = async () => {
  // 连接rpc节点
  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  // new 出钱包实例
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);
  // 读取合约
  const abi = fs.readFileSync("./index_sol_Index.json", "utf8");
  // 读取
  const binary = fs.readFileSync("./index_sol_Index.bin", "utf8");
  // new出合约实例
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("正在部署中，请稍等...");
  // 部署合约
  const contract = await contractFactory.deploy();
  // 这个时候已经可以查看合约地址，但是链上还没有确认，所以我们在确认之后在查
  console.log(await contract.getAddress());
  // 查询合约部署信息
  await contract.deploymentTransaction().wait();
  // 确认之后进行查询合约地址
  console.log(await contract.getAddress());
  // 调用合约retrieve函数 获取合约中的favoiteNumber参数
  const favoriteNumber = await contract.retrieve();
  console.log("favoiteNumber", favoriteNumber.toString());
  const tx = await contract.store("7");
  await tx.wait();
  const newFavoriteNumber = await contract.retrieve();
  console.log("newFavoriteNumber", newFavoriteNumber.toString());
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

*/
