// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";


interface IWETH {
    function balanceOf(address) external view returns (uint256);
    function deposit() external payable;
}

contract ForkTest is Test {
       IWETH public weth;

    function setUp() public {
           weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    function testDeposit() public {
    // initial amount deposit 66

    weth.deposit{value:69}();

    uint256 initialamount = weth.balanceOf(address(this));
    console.log("Balance - initialamount", initialamount);

    // Deposit WETH (separate call, not within balanceof)
    weth.deposit{value: 420}();

    uint256 balAfter = weth.balanceOf(address(this));
    console.log("Balance After Deposit 420 =", balAfter);
}


}