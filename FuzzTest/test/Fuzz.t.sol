// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Bit} from "../src/Bit.sol";

contract  FuzzTest is Test {
    Bit public bit;

    function setup() public {
        bit = new Bit();
    }
}