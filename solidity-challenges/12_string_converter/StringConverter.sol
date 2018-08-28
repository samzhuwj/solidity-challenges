/*
  create function to convert string to bytes32
  add Solidity test for that function
  创建函数，将字符串转换为bytz 32
  为该函数添加可靠性测试
*/
pragma solidity ^0.4.24;

contract StringConverter {
    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }
}
