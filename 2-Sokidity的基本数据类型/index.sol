// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

contract Index {
    // 创建一个变量
    bool hasFavoriteNumber = true;
    uint favoriteNumber = 1;
    int favoriteNumber2 = -1;
    string favoriteString = "hello world";
    address favoriteAddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    bytes11 favoriteBytes = "hello world"; // 字符串 "hello world" 由 11 个字符组成
    bytes favoriteBytes2 = "hello world";
}
/*
   基本类型有
   布尔类型 boolean   { true, false } 默认值是 false
   正整型 uint   { 1 ,2 ,3 .... } 默认值是 0
   整数 int      {-2 ,-1 , 1 ,2 ,3 .... } 默认值是 0
   字符串 string    '阿迪达斯啊' 默认值为空字符串 "
   地址类型 address  就是地址   默认值是 0x0000000000000000000000000000000000000000
   bytes 是一种动态字节数组类型，用于存储任意长度的二进制数据  默认值根据字节不同  4 个字节的零字节序列 0x00000000  一个 8 个字节的零字节序列 0x0000000000000000

   int 和 uint 默认的都是 256 位bit来存储数值信息
   int 和 uint 的区别是 int 可以存储负数，而 uint 只能存储正数
   我们可以在 int 和 uint 加上一个数字，比如
   int8 int 是整数，正数和负数都可以赋值 8 表示 8 个bit来存储数值信息 最大值为 2的7次方 - 1  最小为 -2的7次方
   uint8 uint 是正整数，最大值为 2的8次方 - 1 最小值为 0
   bytes 后面可以跟一个数字，比如 bytes11 表示 11 个字符组成 范围是 1 - 32
   bytes 没有跟数字的版本，在 Solidity 中是一个动态字节数组，它可以存储从 0 到最大整数（uint256 的最大值减去一定的开销）的字节数
*/
