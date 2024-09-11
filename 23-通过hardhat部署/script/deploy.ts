// 导入ethers工具库中的hardhat配置
const { ethers } = require("hardhat");

/**
 * 部署Index智能合约的主要异步函数
 */
const main = async () => {
  // 获取Index合约的工厂实例
  const IndexFactory = await ethers.getContractFactory("Index");
  // 部署Index合约
  const index = await IndexFactory.deploy();
  // 等待合约部署完成
  await index.waitForDeployment();
  // 输出合约的目标地址
  console.log(index.target);
  // 输出合约实例信息
  console.log(index);
  const favoiteNumber = await index.retrieve();
  console.log("favoiteNumber", favoiteNumber);
  const tx = await index.store(123);
  console.log("tx", tx);
  const res = await tx.wait();
  console.log("res", res);
  if (res.status) {
    console.log("合约部署 success");
  }
  const newFavoiteNumber = await index.retrieve();
  console.log("newFavoiteNumber", newFavoiteNumber);
};

// 调用main函数，开始执行合约部署流程
main();
/*
ethers.getContractFactory 是一个用于获取合约工厂实例的方法，合约工厂是一个用于部署新合约实例的对象。
*/
