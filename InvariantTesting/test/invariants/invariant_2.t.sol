// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
// import {InvariantIntro} from "../../src/InvariantIntro.sol";
import {WETH} from "../../src/WETH.sol";

// Topics
// - handler based testing - test functions under specific conditions
// - target contract
// - target selector

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract Handler is CommonBase, StdCheats, StdUtils {
    WETH private weth;
    uint256 public wethBalance; //eth Bal deposited or withdraw by handler contract

    constructor(WETH _weth) {
        weth = _weth;
    }

    receive() external payable {}

    function sendToFallback(uint amount) public{
        amount = bound(amount, 0, address(this).balance);
        wethBalance += amount;
        (bool success,)= address(weth).call{value:amount}("");
    require (success , "sendTofallback failed");
    }

    function deposit(uint amount ) public {
           amount = bound(amount, 0, address(this).balance); // native Balance
           wethBalance += amount;
           weth.deposit{value:amount}();
    }

    function withdraw(uint amount ) public {
        //   amount = bound(amount,0,address(weth).balance);
          amount = bound(amount,0,weth.balanceOf(address(this))); // WETH Balance of Handler Contract
          wethBalance -= amount;
          weth.withdraw(amount);
    }

    function fail () public {   //it is not called by the foundry
    // because of the target selector.
        revert("failed");
    }
}

contract WETH_Handler_Based_Invariant_Test is Test {
    WETH public weth;
    Handler public handler;

    function setUp() public {
        weth = new WETH();
        handler = new Handler(weth);
        deal(address(handler), 100 * 1e18); // 100 ETh Assign to handler Contract.
        // - target contract
        targetContract(address(handler)); // Test all public function of handler Contract.

        // - target selector
        bytes4 [] memory selectors = new bytes4[](3);
        selectors[0] = handler.sendToFallback.selector;
        selectors[1] = handler.deposit.selector;
        selectors[2] = handler.withdraw.selector;
        // selectors[3] = handler.fail.selector;

        targetSelector(
            FuzzSelector({addr: address(handler), selectors: selectors})
        );

    }

    function invariant_eth_balance() public {
        assertGe(address(weth).balance , handler.wethBalance());
        // assertGe(address(weth).balance , address(handler).balance);
    }
   


}
