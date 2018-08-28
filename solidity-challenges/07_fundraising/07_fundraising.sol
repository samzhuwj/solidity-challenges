/*
  fundraising has the goal to reach (amount is set on creation)
  fundraising has the time limit (time is set on creation)
  anyone can add any amount until time is up or the goal is reached
  when the time is up but the goal is not reached users can withdraw their funds
  when the goal is reached owner can withdraw all the money
  有筹款目标的(创立时设定数额)
  筹资有时间限制(创立时设定时间)
  任何人都可以增加任何金额，直到时间结束或目标达到为止。
  时间到了，但目标尚未完成，用户可以撤回他们的资金。
  当目标达到时，所有者可以取出所有钱
*/
pragma solidity ^0.4.22;

contract FundRaising {
    address owner;
    uint public goal;
    uint public endTime;
    uint public total = 0;

    mapping(address=>uint) donations;

    constructor(uint _goal, uint _timeLimit) public {
        owner = msg.sender;
        goal = _goal;
        endTime = now + _timeLimit;
    }

    function add() payable public {
        require(now < endTime, "Fundraising is closed.");
        require(total < goal, "We reached a goal.");
        require(msg.value > 0, "You need to send some ether");
        donations[msg.sender] += msg.value;
        total += msg.value;
    }

    function withdrawOwner() public {
        require(msg.sender == owner, "You must be owner");
        require(total >= goal, "Fundraising not closed yet");
        owner.transfer(address(this).balance);
    }

    function withdraw() public {
        require(now > endTime, "Fundraising not closed");
        require(total < goal, "Can not withdraw when fundraising was successful");
        uint amount = donations[msg.sender];
        total -= amount;
        donations[msg.sender] = 0;
        address(msg.sender).transfer(amount);
    }
}
