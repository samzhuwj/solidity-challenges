/*
  contract must store a list of bus stops
  each bus stop has id, name and coordinates (i.e czn1, PKS Cieszyn, 10.123222, 33.212345)
  owner should be able to add new stops
  contract must have test coverage
  合约内必须存储公交车站的列表。
  每个公共汽车站都有id、名称和坐标(例如：czn 1、PKS Cieszyn、10.123222, 33.212345)
  所有者能够添加新的站点
  合约必须有测试范围
*/
pragma solidity ^0.4.24;

contract RouteManager {
    address public owner;

    struct Stop {
        bytes4 id;
        bytes32 name;
        bytes10 latitude;
        bytes10 longitude;
    }

    Stop[] public stops;

    constructor() public {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(msg.sender == owner, "must be owner");
        _;
    }

    function addStop(
        bytes4 _id,
        bytes32 _name,
        bytes10 _latitude,
        bytes10 _longitude
    ) public isOwner {
        stops.push(Stop(_id, _name, _latitude, _longitude));
    }

    function getStopId(uint _n) public view returns(bytes4) {
        return stops[_n].id;
    }

    function getStopCount() public view returns(uint) {
        return stops.length;
    }
}
