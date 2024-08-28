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
  console.log(contract);
  // 查询合约部署信息
  const transactionReceipt = await contract.deploymentTransaction().wait();
  console.log(`合约部署事务：`);
  console.log(contract.deploymentTransaction);
  console.log(`合约部署信息：`);
  console.log(transactionReceipt);

  // 通过发送交易的形式部署合约
  //   const nonce = await wallet.getNonce();
  //   const tx = {
  //     nonce,
  //     gasPrice: 20000000000,
  //     gasLimit: 3000000,
  //     to: null,
  //     value: 0,
  //     data: "0x608060405234801561001057600080fd5b5061017f806100206000396000f3fe608060405234801561001057600080fd5b50600436106100415760003560e01c80632e64cec114610046578063536f964d146100645780636057361d14610082575b600080fd5b61004e61009e565b60405161005b9190610108565b60405180910390f35b61006c6100a7565b6040516100799190610108565b60405180910390f35b61009c600480360381019061009791906100cc565b6100ad565b005b60008054905090565b60005481565b8060008190555050565b6000813590506100c681610132565b92915050565b6000602082840312156100e2576100e161012d565b5b60006100f0848285016100b7565b91505092915050565b61010281610123565b82525050565b600060208201905061011d60008301846100f9565b92915050565b6000819050919050565b600080fd5b61013b81610123565b811461014657600080fd5b5056fea2646970667358221220ee5bd282e0fb59e25177981566e114e6310eeb47671fe83ceefc25bd7a181edb64736f6c63430008070033",
  //     chainID: 5777,
  //   };
  //   const signedTx = await wallet.sendTransaction(tx);
  //   await signedTx.wait();
  //   console.log(signedTx);
};

deploy().then(
  () => {
    console.log("success");
  },
  (error) => {
    console.log("error", error);
  }
);

/*
  contract.deploymentTransaction 是 ethers.js 中的一个属性，它返回一个对象，该对象包含了用于部署智能合约的原始交易信息。
  当你使用 ethers.ContractFactory.deploy() 方法部署一个智能合约时，这个方法会返回一个合约实例，而这个实例上的 deploymentTransaction 属性就是部署交易的信息。
  contract.deploymentTransaction 是你在创建交易的时候获得的
  contract.deploymentTransaction().wait() 是交易回执
*/
