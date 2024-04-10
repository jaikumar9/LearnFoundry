// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract TimeTest is Test {
      
      Auction public auction;
      uint256 private startAt;

    //  vm.warp = set block.timestamp to future timestamp 
    //  vm.roll = set block number 
    //  skip = increment current timestamp
    //  rewind = decrement current timestamps

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }
  
    function testBitFailsBeforeStartTime() public {
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }
     
     function testBitAfterStartTime() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

     function testBidFailsAfterEndTime() public {
        vm.expectRevert(bytes("cannot bid"));
        vm.warp(startAt + 2 days);
        auction.bid();
}

     function testTimeStamp ()  public {
        uint t = block.timestamp;
        //  skip = increment current timestamp
        skip(420);
        assertEq(block.timestamp, t + 420);
        //  rewind = decrement current timestamps
        rewind(69);
        assertEq(block.timestamp, t + 420 - 69);
     }

     function testBlockNumber ()  public {
        //  vm.roll = set block number  
        uint B = block.number;
        vm.roll(42069);
        assertEq(block.number,42069);
     }

      function testFailBlockNumber ()  public {
        //  vm.roll = set block number  
        uint B = block.number;
        vm.roll(420);
        assertEq(block.number,69);
     }
}