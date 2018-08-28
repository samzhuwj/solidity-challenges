/*
  create your own ERC20 token using Open Zeppelin implementation
  inherit from "StandardToken"
  add custom name, symbol, decimals and initial supply
  使用OpenZeppelin创建你自己的ERC 20令牌
  继承“标准token”
  添加自定义名称、符号、小数和初始供应
*/
pragma solidity ^0.4.24;

import "zeppelin/contracts/token/StandardToken.sol";

contract PiotrexToken is StandardToken {
    string public constant name = "PiotrexToken";
    string public constant symbol = "PTX";
    uint8 public constant decimals = 18;
    uint256 public constant initialSupply = 1000 * (10 ** uint256(decimals));

    constructor () public {
        balances[msg.sender] = initialSupply;
        totalSupply = initialSupply;
    }
}
