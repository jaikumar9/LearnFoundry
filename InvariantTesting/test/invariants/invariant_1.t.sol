// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
// import {InvariantIntro} from "../../src/InvariantIntro.sol";
import {WETH} from "../../src/WETH.sol";

// NOTE: open tseting - randomly calls all public functions

contract WETH_Open_Invariants_Tests is Test {
    WETH public weth;

    function setUp() public {
        weth = new WETH();
    }

    function invariant_totalSupply_is_always_zero () public {
            assertEq(weth.totalSupply(),0);
    }
}