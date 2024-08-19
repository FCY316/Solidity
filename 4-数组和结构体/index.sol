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
    function addPerson(string memory _name, uint _age) public {
        people.push(People(people.length, _name, _age));
    }
}

/*
    struct People {
        uint id;
        string name;
        uint age;
    }
    struct 是自定义结构的关键字
    People 是结构的名称
    id, name, age 是结构的成员
    uint, string, uint 是成员类型
    定义后我们就可以使用这个结构体，结构体可以当作类型来使用，
    当定义了一个结构体时，会自动生成一个构造函数，这个构造函数接受与结构体成员相同数量和类型的参数，并按顺序初始化这些成员。

    People[] public people;
    是声明一个结构体数组，这个数组可以存储任意数量的结构体实例
    People[3] 则代表只允许存储3个结构体实例

    memory 的作用是：
      使用 memory 关键字声明 newPerson 表示这个 People 实例是在内存中创建的，并且将在 push 到 people 数组中时被复制到存储中。
    函数参数:
      当你传递一个较大的数据类型（如数组或结构体）给一个函数时，使用 memory 可以避免将整个数据复制到存储中，而是将它放在内存中，这可以节省 gas 成本。
    局部变量:
      当你创建一个临时变量，仅在函数执行期间需要它时，可以使用 memory 关键字。这些变量在函数执行结束后会被销毁，不会保存在智能合约的永久存储中。
    返回值:
      当你从一个函数返回一个较大的数据类型时，使用 memory 关键字可以确保返回值是在内存中创建的，而不是存储中。
    函数调用:
      当你调用一个外部函数时，如果需要传递一个较大的数据类型作为参数，使用 memory 可以避免不必要的复制。
    临时变量:
      当你需要在函数中创建一个临时变量，用于临时存储数据或进行中间计算时，使用 memory 关键字可以确保这些变量只存在于函数执行期间。
    string 在 Solidity 中被视为基本数据类型之一，但它与其他基本数据类型（如 uint 和 bool）有所不同，因为它是一个较大的数据类型。
 */
