// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bit} from "../src/Bit.sol";

// Topics
// - fuzz
// - assume and bound
// - stats
//   (runs: 256, μ: 18301, ~: 10819)
//   runs - number of tests
//   μ - mean gas used
//   ~ - median gas used

contract FuzzTest is Test {
    Bit public bit;

    function setUp() public {
        bit = new Bit();
    }

    function mostSignificantBit(uint256 x) private pure returns (uint256) {
        uint256 i = 0;
        while ((x >>= 1) > 0) {
            i++;
        }
        return i;
    }

    function testMostSignifientBitManual() public view {
        assertEq(bit.mostSignificantBit(0), 0);
        assertEq(bit.mostSignificantBit(1), 0);
        assertEq(bit.mostSignificantBit(2), 1);
        assertEq(bit.mostSignificantBit(4), 2);
        assertEq(bit.mostSignificantBit(8), 3);
        assertEq(bit.mostSignificantBit(type(uint256).max), 255);
    }

    function testMostSignifientBitFuzz(uint256 x) public {
        uint j = bit.mostSignificantBit(x);
        assertEq(j, mostSignificantBit(x));
    }

    function testMostSignifientBitFuzz2(uint256 x) public {
        // assume - If false, the fuzzer will discard the current fuzz inputs
        // and start a new fuzz run.
        // Skip x = 0

        vm.assume(x > 0);
        assertGt(x, 0);

        uint j = bit.mostSignificantBit(x);
        assertEq(j, mostSignificantBit(x));
    }

     function testMostSignifientBitFuzz3(uint256 x) public {
        
        //bound (input, min, max) -bound input between min and max.

        x = bound(x,69,420);
        assertGe(x, 69);
        assertLe(x, 420);

        uint j = bit.mostSignificantBit(x);
        assertEq(j, mostSignificantBit(x));
    }

}
