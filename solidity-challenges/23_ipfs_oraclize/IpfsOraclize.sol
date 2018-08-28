/*
  add a simple json file to ipfs
  use oraclize to read that file
  store the result of one json attribute in a string variable
  向IPF中添加一个简单的json文件
  使用Oraclize读取该文件
  将一个json属性的结果存储在字符串变量中
  Learn more about setting a IPFS node: https://michalzalecki.com/set-up-ipfs-node-on-the-server/
*/
pragma solidity ^0.4.24;

import "../utils/usingOraclize.sol";

contract IpfsOraclize is usingOraclize {
    string public body;

    constructor() public payable {
        update();
    }

    function __callback(string result) public {
        require(msg.sender == oraclize_cbAddress());
        body = result;
    }

    function update() public payable {
        oraclize_query("IPFS", "json(QmYyuvuafPFxDvRmeLgCkhQEnmNs1fxQW9hAsgj7gvrSV2).body");
    }
}
