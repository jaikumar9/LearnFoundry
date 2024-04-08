// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/Console.sol";
import {Wallet} from "../src/Wallet.sol";

contract AuthTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    function test_balance() public view {
        assertEq(address(wallet).balance, 0);
        console.log(address(wallet).balance);
    }

    function test_checkOwner() public {
        console.log(wallet.owner());
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
        console.log(wallet.owner());
    }

    function testFail_notOwner() public {
        console.log(wallet.owner());
        vm.prank(address(2));
        wallet.setOwner(address(3));
        console.log(wallet.owner());
    }

    function testFail_OwnerAgain() public {
        // msg.sender = address(this)
        console.log(wallet.owner());
        wallet.setOwner(address(1));

        // msg.sender = address(1)
        vm.startPrank(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        vm.stopPrank();
        //msg.sender = address(this)
        wallet.setOwner(address(1));
    }

}
