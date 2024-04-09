// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Event} from "../src/Event.sol";

contract EventTest is Test {
    Event public eventT;
 
 event Transfer(address indexed from, address indexed to, uint256 value);

    function setUp() public {
        eventT = new Event();
    }

    function testEmitTransferEvent() public {
        //  function expectEmit(
        //     bool checkTopic1,
        //     bool checkTopic2,
        //     bool checkTopic3,
        //     bool checkData,
        //     address emitter,
        //  ) external;

        // 1. Tell foundry which data to check 
        // check index 1, index 2 and data.

        vm.expectEmit(true, true, false, true);
        // 2. Emit the expected event
        emit Transfer(address(this), address(0x1234), 100);
        // 3. Call the function that emits the event
        eventT.transfer(address(this), address(0x1234), 100);
        
        // Check Index 1
        vm.expectEmit(true, false, false, false);
        // 2. Emit the expected event
        emit Transfer(address(this), address(0x1234), 100);
        // 3. Call the function that emits the event
        eventT.transfer(address(this), address(0x1233), 1008567);
    }

    function testEmitManyTransferEvent() public {
        // 1. Tell foundry which data to check 
        // 2. Emit the expected event
        // 3. Call the function that emits the event
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this),[0x321], 100);
        eventT.transferForMany(address(this), [0x321], 100);
    }
}