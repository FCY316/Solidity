const { ethers } = require("ethers");
const fs = require("fs-extra");
const deploy = async () => {
  // HTTP://127.0.0.1:7545
  const provider = new ethers.JsonRpcProvider("http://127.0.0.1:7545");
  const wallet = new ethers.Wallet(
    "0xb7df22ee2cb17c9d7e238ffa7af1e398f16da04ea47b2d34435a383a08bcf096",
    provider
  );
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
