// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Index {
    struct User {
        uint256 id;
        uint256 balance;
    }
    mapping(uint256 => User) public getUser;
    mapping(uint256 => uint256) public getUserBalance;
    User[] user;
    function addUser(uint256 _balance) public {
        getUser[user.length] = User(user.length, _balance);
        getUserBalance[user.length] = _balance;
        user.push(User(user.length, _balance));
    }
    function setUser(uint256 _id, uint _balance) public {
        getUser[_id] = User(_id, _balance);
        getUserBalance[_id] = _balance;
        user[_id] = User(_id, _balance);
    }
}
/*
定义 mapping 的语法如下：
    mapping(KeyType => ValueType) mappingName;
键的唯一性:
    mapping 中的键必须是唯一的，也就是说，相同的键只能对应一个值。
    键可以是 address、bytes32、enum 或者任何其他类型的哈希值。
值的类型:
    值可以是任意类型，包括基本数据类型（如 uint）、结构体、数组或映射本身。
    值可以是动态大小的类型，如 string 或 bytes。
动态存储:
    mapping 存储在智能合约的永久存储中，而不是内存中。
    因此，对 mapping 的任何修改都会永久保存，并且会增加 gas 成本。
不可枚举:
    mapping 本身没有提供遍历所有键值对的方法，这意味着你不能直接迭代 mapping 来获取所有的键或值。
    为了遍历 mapping 中的所有键值对，你需要维护一个额外的数据结构（如数组），用于存储所有的键。
默认值:
    mapping 中不存在的键会返回默认值。对于基本数据类型，这是 0 或 false；对于复杂类型，这是零值。
    mapping 需要   getUserBalance[user.length] = _balance; 这样添加key和值
 */
