// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract FFITest is Test {
    function testFFI() public {
        string[] memory cmds = new string[](2);
        cmds[0] = "cat"; // name of the command
        cmds[1] = "ffi_test.txt"; // file path location
        bytes memory respo = vm.ffi(cmds);
        console.log(string(respo));
    }
}