/*
  user has to pay 0.1 ether to join the lottery
  no limit for users number
  same user can join multiple times
  owner of the contract can join too
  owner decides when to pick the winner
  winner receives all the money
  new lottery starts when the winner is pickecd
  用户支付0.1以太即可加入lottery
  不限用户数量
  同一用户可以多次加入
  合约所有人亦可以加入
  合约所有人决定何时选出赢家
  赢家将得到所有奖金
  选出赢家即可开始新一轮lottery
*/
pragma solidity ^0.4.23;

contract LotteryNoLimit {
    address owner;
    address[] users;
    uint randNonce = 0;

    modifier isOwner() {
        require(msg.sender == owner, "only owner can do that");
        _;
    }

    constructor() public {
        owner = msg.sender;
    }

    function join() payable public {
        require(msg.value == 0.1 ether, "Send 0.1 Ether");
        users.push(msg.sender);
    }

    function selectWinner() public isOwner {
        require(users.length > 0, "No users in the lottery");
        users[randomNumber(users.length)].transfer(address(this).balance);
        delete users;
    }

    function randomNumber(uint _limit) private returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _limit;
        randNonce++;
        return rand;
    }
}
