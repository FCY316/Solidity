// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import "./PriceConveter.sol";
contract FundMe {
    using PriceConveter for uint256;
    uint256 public minnumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    // 要钱函数
    function fund() public payable {
        // require 是 Solidity 中的一个条件检查语句，用于确保某个条件成立。如果条件不成立，则会抛出一个异常并回滚交易。
        // requir(条件，错误信息) 记住会将函数执行回滚 不满足条件 则不会执行后面的代码，相应的会将后面的gas回退
        require(
            msg.value.getConversionRate() >= minnumUsd,
            "You need to spend more ETH!"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
    // 提钱函数
    function withdraw() public {
        for(uint256 funderIndex = 0;funderIndex< funders.length;funderIndex++){
             address funder = funders[funderIndex];
             addressToAmountFunded[funder] = 0;
             funders = new address[](0);
             // 3种提取方法 transfer  send 发送交易都有gas限制为2300，超过会报错
             // 区别在于 transfer 会直接回滚 而send会返回一个布尔值 call 没有gas上限 会返回两个参数 第一个是交易成功？ 第二个不知到
             // transfer  
             payable(msg.sender).transfer(address(this).balance)
             // send
             bool sendSuccess = payable(msg.sender).send(address(this).balance)
             // 使用require进行判断
             require(sendSuccess,'提取失败');
             // call
             (bool callSuccess,) = payable(msg.sender).call{value:address(this).balance}('')
        }
    }
}
/* 
  funders = new address[](0); 
  `new address[](0);` 用于创建一个空的动态数组 然后赋值给funders
   
   payable(msg.sender).transfer(address(this).balance)
   payable(msg.sender):
    msg.sender 是一个全局变量，它返回发送当前交易的外部账户的地址。在这里，我们将 msg.sender 转换为 payable 类型，以便我们可以向该地址发送以太币。
    address(this):
    address(this) 返回当前智能合约的地址。
    .balance:
    .balance 是一个属性，它返回一个账户的以太币余额。在这里，我们获取当前智能合约的以太币余额。
    .transfer():
    .transfer() 是一个内置函数，用于将一定数量的以太币从当前账户发送到另一个账户。这个函数需要一个以太币数量作为参数。

 */