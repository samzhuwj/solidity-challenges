/*
  10 users limit
  user has to pay 0.1 ether to join the lottery
  same user can join once
  owner of the contract can join the lottery
  when 10 users join then the winner is picked
  winner receives all the money
  new lottery starts when the winner is pickecd
  限制为10个用户
  用户必须支付0.1ETH才能加入以太坊彩票
  同一用户只能加入一次
  合约创建者可以加入以太坊彩票
  第10个用户进入后，选择获胜者
  赢家收走所有的钱
  选出获胜者之后，开始下一轮
*/
pragma solidity ^0.4.23;

contract Lottery10Users {
    address[10] participants;
    uint8 participantsCount = 0;
    uint randNonce = 0;

    function join() public payable {
        require(msg.value == 0.1 ether, "Must send 0.1 ether");
        require(participantsCount < 10, "User limit reached");
        require(joinedAlready(msg.sender) == false, "User already joined");
        participants[participantsCount] = msg.sender;
        participantsCount++;
        if (participantsCount == 10) {
            selectWinner();
        }
    }

    function joinedAlready(address _participant) private view returns(bool) {
        bool containsParticipant = false;
        for(uint i = 0; i < 10; i++) {
            if (participants[i] == _participant) {
                containsParticipant = true;
            }
        }
        return containsParticipant;
    }

    function selectWinner() private returns(address) {
        require(participantsCount == 10, "Waiting for more users");
        address winner = participants[randomNumber()];
        winner.transfer(address(this).balance);
        delete participants;
        participantsCount = 0;
        return winner;
    }

    function randomNumber() private returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % 10;
        randNonce++;
        return rand;
    }

}
