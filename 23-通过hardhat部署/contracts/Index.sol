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
