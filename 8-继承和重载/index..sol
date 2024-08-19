// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;
import "../5-calldata,memory,storage/index.sol";

contract Inherit is Index {
    function addPerson(string memory _name, uint _age) public override {
        people.push(People(people.length, _name, _age));
    }
    function getPerson(uint _index) public view returns (People memory) {
        return people[_index];
    }
}
/*
  is 是代表着继承
  override 需要和 virtual 一起使用，想要改变继承的函数，也就是重写，需要在继承的函数上加上 virtual 关键字，然后在当前态下，想要改变继承的函数，需要加上 override 关键字
  当然还可以添加函数
*/
