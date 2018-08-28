/*
  return address of the contract
  return address of the contract's owner
  return address of the sender
  return balance of the contract
  return balance of the contract's owner (ONLY if you are the owner)
  return balance of the sender
  返回合约地址
  返回合约创建者的地址
  返回发送人的地址
  返回合约的余额
  返回合约制定者的余额（仅在你为该合约所有者的前提下）
  返回发送人的余额
*/
pragma solidity ^0.4.22;

contract Checker {
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function getBalanceOfContract() public view returns(uint) {
        return address(this).balance;
    }

    function getBalanceOfOwner() public view onlyOwner returns(uint){
        return owner.balance;
    }

    function getBalanceOfSender() public view returns(uint) {
        return msg.sender.balance;
    }

    function getAddressOfContract() public view returns(address) {
        return this;
    }

    function getAddressOfOwner() public view returns(address) {
        return owner;
    }

    function getAddressOfSender() public view returns(address) {
        return msg.sender;
    }
}
