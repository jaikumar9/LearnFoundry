// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

contract ConsoleTest is Test {

    int x = -1;

    function test_console_log_somthing() public view {
        console.log("Hello world!", 123);
        int y = -2;
        console.logInt( x);
        console.logInt( y);
    }
}