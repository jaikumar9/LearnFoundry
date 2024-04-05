// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { stdError} from "forge-std/stdError.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
}

   function test_count () public view {
    assertEq(counter.count(), 0);
   }

   function test_inc () public {
    counter.inc();
    assertEq(counter.get(), 1);
    counter.inc();
    assertEq(counter.count(), 2);
    counter.inc();
    assertEq(counter.get(), 3);
}

   function testFailDec () public {
    counter.dec();
   }

   function testDecUnderflow () public {   // same as testFailDec but with expectRevert
    vm.expectRevert(stdError.arithmeticError);
    counter.dec();
}
   function test_Dec () public { 
    counter.inc(); // 1
    counter.inc(); // 2
    counter.dec(); // 1
    assertEq(counter.get(), 1);
}
}
