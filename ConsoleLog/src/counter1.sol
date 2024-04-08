// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "forge-std/console.sol";

contract counter1 {
    uint256 public count;

    // Function to get the current count
    function get() public view returns (uint256) {
        return count;
    }
   
    // Function to increment count by 1
    function inc() public {
        console.log("Here is COUNT -", count);
        count += 1;
        console.log("Here is COUNT -", count);
    }

    // Function to decrement count by 1
    function dec() public {
        // This function will fail if count = 0
        console.log("Here is COUNT -", count);
        count -= 1;
        console.log("Here is COUNT -", count);
    }
}
