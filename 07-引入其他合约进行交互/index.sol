// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "../05-calldata,memory,storage/index.sol";

contract Inherit {
    Index public index;

    function createIndex() public {
        index = new Index();
    }

    function addPerson(string memory _name, uint _age) public {
        index.addPerson(_name, _age);
    }
}
/*
import "../5-calldata,memory,storage/index.sol";
contract Inherit {
    Index public index; // 公共状态变量，用于存储 `Index` 合约的一个实例。

    function createIndex() public {
        index = new Index(); // 创建 `Index` 合约的一个新实例，并将其赋值给状态变量 `index`。
    }
}
index 是一个公共状态变量，用于存储 Index 合约的一个实例。
在外部调用显示的是地址
在内部可以通过 index.addPerson(name, age) 来调用 Index 合约的 addPerson 函数。
 */
