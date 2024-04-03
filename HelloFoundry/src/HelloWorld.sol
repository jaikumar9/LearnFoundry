// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract HelloWorld {
   
   string public greeting;

   function setGreet(string memory greet) public {
        greeting = greet;
    }


}