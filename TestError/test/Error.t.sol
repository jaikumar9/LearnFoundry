// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Error} from "../src/Error.sol";

contract ErrorTest is Test {
    Error public error;

    function setUp() public {
        error = new Error();
    }

    function testFail() public view {
        error.throwError();
    }

    function testRevert() public {
        // Doinging same thing as testFail
        vm.expectRevert();
        error.throwError();
    }

    function testRequireWithMessage() public {
        vm.expectRevert(bytes("Not authorized")); // Get the exect revert message
        // if we set the parameter of vm.expectRevert.
        error.throwError();
    }

    function testCustomError() public {
        //To use expectRevert with a custom error type without parameters, use its selector.
        // vm.expectRevert(CustomError.selector);
        vm.expectRevert(Error.NotAuthorized.selector); // Get the exect revert through
        // Custom error.
        error.throwCustomError();
    }

    function testAssertEqLabel() public pure {
        assertEq(uint256(1), uint256(1), "Test 1");
        assertEq(uint256(1), uint256(1), "Test 2");
        assertEq(uint256(1), uint256(1), "Test 3");
        assertEq(uint256(1), uint256(1), "Test 4");
        assertEq(uint256(1), uint256(1), "Test 5");
    }
}
