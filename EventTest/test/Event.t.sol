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
        address[] memory to = new address[](5);
        to[0] = address(111);
        to[1] = address(222);
        to[2] = address(333);
        to[3] = address(444);
        to[4] = address(555);

        uint256[] memory amounts = new uint256[](5);
        amounts[0] = 1;
        amounts[1] = 2;
        amounts[2] = 3;
        amounts[3] = 45;
        amounts[4] = 6;

        for (uint256 i = 0; i < to.length; i++) {
            // 1. Tell Foundry which data to check
            vm.expectEmit(true, true, false, true);
            // 2. Emit the expected event
            emit Transfer(address(this), to[i], amounts[i]);
        }

        // 3. Call the function that should emit the event
        eventT.transferMany(address(this), to, amounts);
    }
}