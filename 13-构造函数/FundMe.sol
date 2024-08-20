// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import "./PriceConveter.sol";
contract FundMe {
    using PriceConveter for uint256;
    uint256 public minnumUsd = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public owner;
    // 构造函数
    constructor() {
        owner = msg.sender;
    }
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
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
            funders = new address[](0);
            (bool callSuccess, ) = payable(msg.sender).call{
                value: address(this).balance
            }("");
            // 使用require进行判断
            require(callSuccess, "call failed");
        }
    }
}
/*
   构造函数在Solidity中用于初始化智能合约的状态变量。当一个新的智能合约实例被部署（即创建）时，构造函数会被自动调用一次。这使得开发者可以在合约首次部署时设置初始状态。
 */
