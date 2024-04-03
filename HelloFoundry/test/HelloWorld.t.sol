// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {HelloWorld} from "../src/HelloWorld.sol";

contract HelloWorldTest is Test {
    HelloWorld public helloWorld;

   function setUp() public {
        helloWorld = new HelloWorld();
        helloWorld.setGreet("HelloWorld");
    }

function testHelloWorld() public view {
    assertEq(helloWorld.greeting(), "HelloWorld");

}

function testcheckString(string memory x) public  {
    helloWorld.setGreet(x);
        assertEq(helloWorld.greeting(),x);
}

}