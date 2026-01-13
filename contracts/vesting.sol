// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


contract Vesting{
    address public employee;
    uint256 public startTime;
    uint256 public cliff;
    uint256 public vesting_duration;
    uint256 public totalAllocation;

    constructor(
        address _employee,
        uint256 _cliff,
        uint256 _vesting_duration,
        uint256 _totalAllocation
    ){
        employee = _employee;
        startTime = block.timestamp;
        cliff = _cliff;
        vesting_duration = _vesting_duration;
        totalAllocation = _totalAllocation;
    }

    function calculateVestedAmount() public view returns ( uint256 ) {
        if (block.timestamp < startTime + cliff){
            return 0;

        }
        if (block.timestamp >= startTime + vesting_duration){
            return totalAllocation;
        }
        uint256 timePassed = block.timestamp - startTime;
        return (totalAllocation * timePassed) / vesting_duration;
    }
}