// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import "./PriceConveter.sol";
contract FundMe {
    using PriceConveter for uint256;
    uint256 public constant MINNUM_USD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    address public immutable i_owner;
    // 构造函数
    constructor() {
        i_owner = msg.sender;
    }
    // 要钱函数
    function fund() public payable {
        // require 是 Solidity 中的一个条件检查语句，用于确保某个条件成立。如果条件不成立，则会抛出一个异常并回滚交易。
        // requir(条件，错误信息) 记住会将函数执行回滚 不满足条件 则不会执行后面的代码，相应的会将后面的gas回退
        require(
            msg.value.getConversionRate() >= MINNUM_USD,
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
        require(msg.sender == i_owner, "You are not owner");
        _;
    }
}
/*
        constant
        类型限制:
        constant 只能用于声明基本数据类型的状态变量，如 uint, int, address, bool 等。
        constant 不支持复杂类型，如数组、结构体或映射。
        编译期确定:
        constant 变量必须在编译时就能确定其值。
        这意味着 constant 变量的值必须是一个常量表达式，不能依赖于运行时的状态。
        初始化:
        constant 变量必须在声明时初始化，不能在构造函数中初始化。
        内存位置:
        constant 变量存储在代码中，而不是存储在合约的存储区域中。
        这意味着 constant 变量不会占用存储空间，也不会影响 gas 成本。

        immutable
        类型支持:
        immutable 支持更广泛的类型，包括基本数据类型和复杂类型，如数组、结构体和映射。
        这使得 immutable 更加灵活，可以用于存储更复杂的数据结构。
        初始化:
        immutable 变量可以在声明时初始化，也可以在构造函数中初始化。
        这意味着 immutable 变量的值可以在运行时确定，只要在合约部署时确定即可。
        内存位置:
        immutable 变量存储在合约的存储区域中，但它们的位置是固定的，不会改变。
        这意味着即使 immutable 变量存储在存储中，它们也不会像普通状态变量那样消耗 gas。
 */
