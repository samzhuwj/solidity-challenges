/*
  create mintable coin (use Open Zeppelin)
  create simple crowdsale (use Open Zeppelin)
  set opening and closing time
  set rate and wallet address
  制造可铸造硬币(使用Open Zeppelin)
  创建简单的众包销售(使用Open Zeppelin)
  设定开启和关闭时间
  固定费率和钱包地址
*/
pragma solidity 0.4.24;

import "./BuseoCoin.sol";
import "zeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "zeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";

contract BuseoCrowdsale is MintedCrowdsale, TimedCrowdsale {
    constructor(
        uint _openingTime,
        uint _closingTime,
        uint _rate,
        address _wallet,
        MintableToken _token
    ) public Crowdsale(_rate, _wallet, _token) TimedCrowdsale(_openingTime, _closingTime) {

    }
}
