/*
  create contract which inherites from Ownable (Open Zeppelin)
  contract must have a list of managers
  owner can add/update/remove manager
  owner is a manager too
  add modifier onlyManager
  创建继承自己的合约(Open Zeppelin)
  合约须有管理员名单
  所有者可以添加/更新/删除管理员
  合约所有者也是管理员
  仅管理员可添加修饰符
*/
pragma solidity 0.4.24;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";

contract Roles is Ownable {
    address owner;

    struct Manager {
        address manager;
        uint managerSince;
        string name;
    }

    Manager[] managers;
    mapping (address => uint) managerId;

    modifier onlyManager {
        require(managerId[msg.sender] != 0, "Only for managers");
        _;
    }

    constructor() public {
        owner = msg.sender;
        addManager(0, "");
        addManager(owner, "owner");
    }

    function addManager(address _targetManager, string _managerName) public onlyOwner {
        uint id = managerId[_targetManager];
        if (id == 0) {
            managerId[_targetManager] = managers.length;
            id = managers.length++;
        }
        managers[id] = Manager({manager: _targetManager, managerSince: now, name: _managerName});
    }

    function removeManager(address _targetManager) public {
        require(managerId[_targetManager] != 0);
        uint indexToRemove = managerId[_targetManager];
        for(uint i = indexToRemove; i < managers.length-1; i++) {
            managers[i] = managers[i+1];
        }
        delete managers[managers.length-1];
        managers.length--;
    }
}
