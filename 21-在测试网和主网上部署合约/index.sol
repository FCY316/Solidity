// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Index {
    uint256 public favoiteNumber;

    function store(uint256 _favoiteNumber) public {
        favoiteNumber = _favoiteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favoiteNumber;
    }
}
/*
   函数的基本格式：
   function 函数名(参数列表) public(这个是可选的，会有4种权限修饰符，public，external，internal，private) {
       函数体
   }
   函数的修饰符：
        public: 可以从智能合约内部和外部被访问，还会为变量生成 getter 函数。
        external: 只能从智能合约外部被调用。
        internal: 可以在定义它的智能合约及其子合约内部被访问。
        private: 只能在定义它的智能合约内部被访问。

    作用域跟js差不多

     function retrieve() public view returns (uint256) {
        return favoiteNumber;
    }
    代码解析
     1.function retrieve(): 这一行声明了一个名为 retrieve 的函数。
     2.view 告诉函数，它不会修改状态变量，因为没有改变变量所以调用需要的gas非常低甚至于为0
     3.returns (uint256): 函数返回一个 uint256 类型的值。
     4.return favoiteNumber: 函数体中，返回 favoiteNumber 的值。


    view:
        表示函数不修改状态变量，只读取状态。
        可以在外部调用时节省gas，因为不需要执行完整的状态变更检查。
        不能在函数内部进行状态更改。
    pure:
        表示函数既不读取也不修改状态变量，并且其输出只取决于输入参数。
        这种函数可以在不同的调用之间产生相同的输出，只要输入相同。
        也不能在函数内部进行状态更改，甚至不能读取状态。
    nonpayable:
        指示函数不允许接收以太币作为交易的一部分。
        默认情况下，所有函数都是 nonpayable 的，除非明确指定为 payable。
    payable:
        允许函数接收以太币作为交易的一部分。
        这对于创建接收支付的函数非常有用，例如众筹合同或简单的支付接口。
 */
