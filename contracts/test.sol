// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract HelloWorld {
  string private greeting;

  constructor(string memory _greeting) {
      greeting = _greeting;
  }

  function sayHello() public view returns(string memory){
      return greeting;
  }
}
