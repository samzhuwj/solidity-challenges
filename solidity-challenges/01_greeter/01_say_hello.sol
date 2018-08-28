/*
  set greeting on creation and allow to change it by the owner (creator of the contract)
  return greeting to everyone who calls `sayHello` method
  return `Hello Daddy` to the creator
  在创建时设置问候语并允许所有者（合约创建者）进行更改
  向每个调用sayHello方法的人返回问候语
  将Hello Daddy返回给创建者
*/
pragma solidity ^0.4.22;

contract Greeter {
    string greeting;
    address owner;

    modifier onlyOwner {
        require(isOwner(), "Only owner can do that!");
        _;
    }

    constructor(string _greeting) public {
        greeting = _greeting;
        owner = msg.sender;
    }

    function sayHello() public view returns(string) {
        if (isOwner()) {
            return "Hey daddy!";
        } else {
            return greeting;
        }
    }

    function setGreeting(string _newGreeting) public onlyOwner {
        greeting = _newGreeting;
    }

    function isOwner() view private returns(bool) {
        return msg.sender == owner;
    }
}
