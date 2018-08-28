/*
  create your own ERC721 token using Open Zeppelin implementation
  inherit from "ERC721Token"
  add custom name and symbol
  使用OpenZeppelin创建自己的ERC 721令牌
  继承“ERC 721 Token”
  添加自定义名称和符号
*/
pragma solidity ^0.4.24;

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/token/ERC721/ERC721Token.sol";

contract DirtyToken is ERC721Token {
    string public constant name = "DirtyToken";
    string public constant symbol = "DRT";
}
