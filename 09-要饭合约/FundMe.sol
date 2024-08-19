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
    // function withdraw() public {}
}
/*
msg 是 Solidity 中的一个全局变量，它提供了关于当前执行上下文的信息。msg 包含了多个属性，这些属性可以帮助你了解谁在调用智能合约函数、调用的方式以及调用时传递的信息等。

msg 的属性
msg 包含以下属性：

msg.sender:
返回发送交易的外部账户的地址。在大多数情况下，这指的是调用智能合约函数的用户的地址。
msg.data:
返回当前调用的数据负载。这对于处理函数调用时传递的数据非常有用。
msg.value:
返回通过本次调用发送到智能合约的以太币数量。当调用一个标记为 payable 的函数时，用户可以附加以太币，msg.value 就是用来获取这个数值的。
msg.gas:
返回剩余的 gas 数量。gas 是以太坊中衡量计算成本的单位，每次调用函数都会消耗一定的 gas。
msg.sig:
返回当前函数调用的前四个字节的签名。这对于确定调用的函数非常有用。
*/
