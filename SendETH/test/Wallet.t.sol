// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/Wallet.sol";

// Example of deal and hoax
  // deal (address, uint) - Setting the balance of the perticular address.
  // hoax (address, uint) - deal + prank, Sets up a prank and set balance.

contract WalletTest is Test {
    Wallet public wallet;

  function setUp() public {
    wallet = new Wallet{value:1e18}();
}
  
function testEthBalance() public view {
    console.log("Wallet Balance initi - ", address(this).balance/1e18);
}

function _sendEth(uint256 amount) private {
    (bool ok, ) = address(wallet).call{value:amount}("");
    require(ok,"Send ETH Failed");
}


function testsendEth() public {
     // deal (address, uint) - Setting the balance of the perticular address.
    uint WalletBalance = address(wallet).balance;
    console.log("Wallet Balance 0", WalletBalance/1e18);

     deal(address(420), 69 * 1e18);
     assertEq(address(420).balance,69* 1e18);

      deal(address(420), 420* 1e18);
     assertEq(address(420).balance,420* 1e18);

     // hoax (address, uint) - deal + prank, Sets up a prank and set balance.

     deal(address(69), 420* 1e18);
     vm.prank(address(69));
     _sendEth(420* 1e18);
    

     hoax(address(69), 42069* 1e18);
     assertEq(address(69).balance,42069* 1e18);
     _sendEth(42069* 1e18);
      
     assertEq(address(wallet).balance, WalletBalance + 420* 1e18 + 42069* 1e18);
   console.log("Wallet Balance 1", address(wallet).balance/1e18);
}
}
