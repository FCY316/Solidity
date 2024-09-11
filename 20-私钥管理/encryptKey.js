const { ethers } = require("ethers");
const fs = require("fs-extra");
require("dotenv").config();

const main = async () => {
  // 用于创建和管理以太坊钱包
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY);
  // 通过实例把私钥进行加密
  const encryptKey = wallet.encryptSync(process.env.PRIVATE_KEY_PASSWORD);
  console.log(encryptKey);
  // 将加密的私钥写入文件
  fs.writeFileSync("./encryptKey.json", encryptKey);
};

main().then(
  () => {
    console.log("success");
  },
  (err) => {
    console.log("error", err);
  }
);
