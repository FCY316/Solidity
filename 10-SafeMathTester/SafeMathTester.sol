// SPDX-License-Identifier: MIT
// pragma solidity 0.6.0;
pragma solidity 0.8.7;

// contract SafeMathTester {
//     uint8 public bigNumber = 255;

//     function add() public {
//         bigNumber = bigNumber + 1;
//     }
// }

contract SafeMathTester {
    uint8 public bigNumber = 255;

    function add() public {
        bigNumber = bigNumber + 1;
    }
}

/*
    uint8 最大数为255
    当前代码，在0.7.6以下 bigNumber = bigNumber + 1; 会将bigNumber=0，跟轮回一样，因为0.7.6以下是遵守unchecked规则的
    0.7.6以上，bigNumber = bigNumber + 1; 会将报错，bigNumber，不会改变，因为0.7.6以上是默认是checked规则的
    要想在0.7.6. bigNumber + 1 = 0，需要将   bigNumber = bigNumber + 1 改为 unchecked {  bigNumber = bigNumber + 1 }
 */
