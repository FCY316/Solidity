// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract FallbackExample {
    uint256 public result;

    receive() external payable {}

    fallback() external payable {}
}
/*
   receive()
        无参数:
        receive() 函数没有参数，它专门用于处理发送到智能合约的纯以太币支付，而不包含任何数据负载。
        支付功能:
        当一个外部账户或智能合约向智能合约发送以太币，并且没有指定任何函数调用时，receive() 函数会被调用。
        这通常用于实现简单的支付功能。
        必须是 payable:
        receive() 函数必须声明为 payable，这意味着它可以接收以太币。

   fallback()
        默认函数:
        fallback() 函数是一个默认函数，它在智能合约接收到一个未指定函数调用时被调用。
        这意味着当调用者发送了一个包含数据负载但没有匹配的函数签名时，fallback() 函数会被调用。
        可以有参数:
        fallback() 函数可以接收任意的数据负载，通常使用 bytes 类型。
        支付功能:
        类似于 receive() 函数，fallback() 函数也可以声明为 payable 来接收以太币。

    区别
        数据负载:
        receive() 函数不接受数据负载。
        fallback() 函数可以接受数据负载。
        调用时机:
        receive() 函数仅在发送纯以太币时被调用。
        fallback() 函数在发送包含数据负载但没有匹配的函数签名时被调用。


receive() 函数用于处理发送到智能合约的纯以太币支付。
fallback() 函数用于处理包含数据负载但没有匹配函数签名的调用。
 */
