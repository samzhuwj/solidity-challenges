/*
  intial supply of tokens is set on creation
  contract creator gets initial tokens
  tokens can be transferred to any account
  there is a protection from overflow
  everyone can check balances
  创造时设定代币的初始供应量
  合约创建者获得初始Token
  Token可以转移到任何帐户
  有保护措施以防止溢出
  任何人可检查余额
*/
pragma solidity ^0.4.22;

contract BasicToken {
    uint public initialSupply;

    mapping(address=>uint) balances;

    constructor(uint _initialSupply) public {
        initialSupply = _initialSupply;
        balances[msg.sender] = _initialSupply;
    }

    function transfer(address _recipient, uint _amount) public {
        require(balances[msg.sender] >= _amount, "Not enough funds");
        require(_recipient != msg.sender, "No need to send tokens to yourself");
        require(balances[_recipient] + _amount > balances[_recipient]); //overflow check
        balances[msg.sender] -= _amount;
        balances[_recipient] += _amount;
    }

    function balanceOf(address _owner) public view returns (uint) {
        return balances[_owner];
    }
}
