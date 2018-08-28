/*
  return random number 0-99
  the "financial importance" of this calculation is less than miner would get for mining single block
  https://ethereum.stackexchange.com/questions/419/when-can-blockhash-be-safely-used-for-a-random-number-when-would-it-be-unsafe?noredirect=1&lq=1
  返回0-99之间的随机数
  计算中的“财务重要性”小于矿工挖掘单一区块得到的
  如何将BLOCKHASH安全地用于随机数？
*/
pragma solidity ^0.4.23;

contract BasicRandom {
    uint randNonce = 0;

    function getRandomNumber() public returns(uint) {
        uint rand = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce)));
        randNonce++;
        return rand;
    }
}
