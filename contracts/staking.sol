// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Staking{
    mapping (address => uint256) public stakedbalance;

    mapping (address => uint256) public LastupdatedTime;

    mapping (address => uint256) public rewards;

    uint256 public constant REWARD_RATE = 1;

    function stake(uint256 _amount) public {
        require(_amount > 0 , "Balance is 0");

        updateReward(msg.sender);

        stakedbalance[msg.sender] += _amount;

    }

    function withdraw(uint256 _amount) public {
        require(stakedbalance[msg.sender] >= _amount, "Insufficent balance");

        updateReward(msg.sender);

        stakedbalance[msg.sender] -= _amount;
    }

    function rewardscheck(address _account) public view returns (uint256){
        uint256 currentReward = rewards[_account];

        uint256 timePassed = block.timestamp - LastupdatedTime[msg.sender];
        uint256 pendingReward = stakedbalance[msg.sender] * REWARD_RATE * timePassed;

        return currentReward + pendingReward;

    }

    function updateReward(address _account) internal {
        rewards[_account] = rewardscheck(_account);
        LastupdatedTime[_account] = block.timestamp;
    }
}