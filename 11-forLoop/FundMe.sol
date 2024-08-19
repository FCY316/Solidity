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
             address funder = funders[funderIndex]
             addressToAmountFunded[funder] = 0
        }
    }
}
/* 
  for(uint256 funderIndex = 0;funderIndex< funders.length;funderIndex++){
             address funder = funders[funderIndex]
             addressToAmountFunded[funder] = 0
        }
    是for循环
    for(初始化参数; 结束条件; 更新条件){
       执行逻辑
    }
 */