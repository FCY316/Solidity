// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Index {
    struct People {
        uint id;
        string name;
        uint age;
    }
    People public person = People(1, "Joe", 30);
    People[] public people;
    function addPerson(string memory _name, uint _age) public virtual {
        people.push(People(people.length, _name, _age));
    }
    function getPeople() public view returns (People[] memory) {
        return people;
    }
}
/*
calldata:
    calldata 是一个只读的内存区域，用于存储函数调用的数据（即函数参数）。
    calldata 变量是不可修改的，只能用于读取数据。
    calldata 在函数调用时创建，并且在函数执行结束时销毁。
    使用 calldata 可以显著减少 gas 成本，因为它比 memory 和 storage 更便宜。
    适用于不需要修改的大型数据结构，如字符串或较大的数组。
memory:
    memory 是一个临时的内存区域，用于存储函数执行过程中创建的临时数据。
    memory 变量是可修改的，但它们只在函数执行期间存在，并在函数执行结束时销毁。
    通常用于函数参数、局部变量以及返回值。
    比 storage 更便宜，但比 calldata 贵。
    适用于需要修改的大型数据结构，如字符串或较大的数组。
storage:
    storage 是智能合约的永久存储区域，用于存储智能合约的状态变量。
    storage 变量是可修改的，并且在整个智能合约的生命周期中一直存在。
    存储变量的读写操作是最昂贵的，因为它们涉及到智能合约的永久状态。
    适用于需要持久化存储的数据，如状态变量和映射。
 */
