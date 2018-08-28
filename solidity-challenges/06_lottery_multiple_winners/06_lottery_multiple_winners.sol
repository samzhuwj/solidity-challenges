/*
  no limit for users
  user joins paying 0.1 eth and picking number 1-100
  owner decides when to generate random number (1-100)
  users who picked generated numbers win
  total prize is distributed to all winners
  对用户无限制
  用户须支付0.1 ETH和并从1-100中挑选一个数字
  合约所有者决定何时生成随机数(1-100)
  选择生成数字的用户获胜
  所有奖励将分配给所有赢家
*/
pragma solidity ^0.4.23;

contract LotteryMultipleWinners {
    address owner;
    uint randNonce = 0;
    address[] winners;
    uint prize;

    enum LotteryState { Accepting, Finished }
    LotteryState state;

    mapping (address => bool) gotReward;
    mapping (uint => address[]) choices;

    modifier isOwner {
        require(msg.sender == owner, "Must be owner");
        _;
    }

    constructor() public {
        owner = msg.sender;
        state = LotteryState.Accepting;
    }

    function join(uint8 _chosenNumber) payable public {
        require(_chosenNumber > 0 && _chosenNumber <= 100, "Number must be in 1-100");
        require(msg.value == 0.1 ether, "Transfer 0.1 Eth to join");
        require(state == LotteryState.Accepting, "Lottery is closed");
        choices[_chosenNumber].push(msg.sender);
    }

    function selectWinners() public isOwner returns(uint) {
        state = LotteryState.Finished;
        uint chosen = randomNumber(100) + 1;
        winners = choices[chosen];
        prize = address(this).balance / winners.length;
    }

    function withdrawReward() public {
        require(isWinner(), "You must be a winner");
        require(gotReward[msg.sender] != true, "You have got your reward");
        gotReward[msg.sender] = true;
        msg.sender.transfer(prize);
    }

    function isWinner() public view returns(bool) {
        for(uint i = 0; i < winners.length; i++) {
            if (winners[i] == msg.sender) {
                return true;
            } else {
                return false;
            }
        }
    }

    function randomNumber(uint _limit) internal returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _limit;
        randNonce++;
        return rand;
    }

}
