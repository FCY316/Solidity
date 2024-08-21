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
    function withdraw() public onlyOwner {
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
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }
}
/*
 modifier onlyOwner 修改器用于确保只有合约的所有者才能执行某些函数。这种修改器通常用于保护合约中的关键函数不被未经授权的用户调用。
 在FundMe合约中，我们定义了一个名为onlyOwner的修改器，用于检查调用当前函数的账户是否是合约的所有者。如果调用者不是所有者，则抛出一个异常并回滚交易。
 使用修改器的好处是，我们可以在函数声明中直接使用修改器，而不必在函数内部重复编写相同的检查代码。
        modifier onlyOwner() {
                require(msg.sender == owner, "You are not owner");
                _;
            }
            这样代表着先执行require，再执行_  _是所修饰的函数的执行逻辑

              modifier onlyOwner() {
                _;
                require(msg.sender == owner, "You are not owner");
            }
            这样代表着先执行所修饰的函数的执行逻辑 ，再执行require
 */
