// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/Interfaces/IERC20.sol";

contract ForkTest is Test {
      IERC20 public dai;

      function setUp() public {
        dai =  IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
      }

       function testDeposit() public {
            address jai = address(12345);

             console.log(dai.balanceOf(jai)/1e18,"Before minting Dai");
             
             uint totalbefore = dai.totalSupply();
             console.log(totalbefore/1e18, "before minting");

            deal(address(dai),jai,1e7 * 1e18,true); //mint new 10M Dai to Jai

            console.log(dai.balanceOf(jai)/1e18,"After minting 10M Dai to Jai");
            assertEq(dai.balanceOf(jai),10000000000000000000000000);
            assertEq(dai.balanceOf(jai),1e7*1e18);

            uint totalAfter = dai.totalSupply(); // total supply state changes due to last arrgument in deal().
            console.log(totalAfter/1e18,"After minying");
       }

}