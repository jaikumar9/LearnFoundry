// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {counter1} from "../src/counter1.sol";
import {stdError} from "forge-std/stdError.sol";

contract counter1Test is Test {

    counter1 public Counter1;
      
      function setUp() public {     // Deploy the contract before each test
        Counter1 = new counter1();
      }

      function test_increment() public {
        Counter1.inc();
        assertEq(Counter1.get(), 1);
      }

      function testFailDec() public{
        Counter1.dec();
      }

      function testDecUnderflow() public{
        vm.expectRevert(stdError.arithmeticError); 
        Counter1.dec();
}

      function test_increment_dec() public {
        Counter1.inc();
        Counter1.dec();
        assertEq(Counter1.get(), 0);
}
}