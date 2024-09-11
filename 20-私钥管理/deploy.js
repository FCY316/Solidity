const { ethers } = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

const deploy = async () => {
  // HTTP://127.0.0.1:7545
  // 连接rpc节点
  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  // 读取加密私钥
  const encryptKey = fs.readFileSync("./encryptKey.json", "utf8");
  // 解密出钱包实例
  let wallet = ethers.Wallet.fromEncryptedJsonSync(
    encryptKey,
    process.env.PRIVATE_KEY_PASSWORD
  );
  // 解密出来的钱包实例没有连接rpc，故通过connect连接上rpc，这样才是一个完整的可以在链上进行数据操作的实例钱包
  wallet = wallet.connect(provider);
  // 读取合约
  const abi = fs.readFileSync("./index_sol_Index.json", "utf8");
  // 读取
  const binary = fs.readFileSync("./index_sol_Index.bin", "utf8");
  // new出合约
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("正在部署中，请稍等...");
  const contract = await contractFactory.deploy();
  // 查询合约部署信息
  await contract.deploymentTransaction().wait();

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
  如果你觉得还是不安全可以使用终端命令输入私钥和rpc 然后在运行
  PRIVATE_KEY=0xb7df22ee2cb17c9d7e238ffa7af1e398f16da04ea47b2d34435a383a08bcf096 RPC_URL=http://127.0.0.1:7545 node deploy.js

  上面的代码其实 在别的地方通过私钥new出钱包实例后，再加密钱包实例存放起来，然后通过读取加密后的钱包实例，解密出来，再通过connect连接上rpc，也就是说可以不暴露私钥进行操作，
  但是黑客可以在前端扒出加密的私钥和加密密码进行解密，这样一看只是增加了解密成本而已
*/
