/*
  add fallback to accept the payment
  add withdraw method which allows anyone to get maximum 1 ether
  log both amounts (paid, transferred) using events
  添加回退函数以接受付款
  增加退出功能，每人最多能得到1ETH
  使用事件记录两个金额(已支付、转移)
*/
pragma solidity 0.4.24;

contract Faucet {
    event ReceivedEthers(uint);
    event WithdrawEthers(uint);

    constructor() payable public {
    }

    function withdraw(uint withdrawAmount) public {
	    require(withdrawAmount <= 1 ether, "No more than 1 Ether");
	    emit WithdrawEthers(withdrawAmount);
        msg.sender.transfer(withdrawAmount);
    }

	function() public payable {
        emit ReceivedEthers(msg.value);
    }
}
