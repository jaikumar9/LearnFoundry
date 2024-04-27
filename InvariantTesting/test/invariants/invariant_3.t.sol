// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "forge-std/console.sol";
// import {InvariantIntro} from "../../src/InvariantIntro.sol";
import {WETH} from "../../src/WETH.sol";
import {Handler} from "./invariant_2.t.sol";

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract ActorManager is CommonBase, StdCheats, StdUtils {
    Handler[] public handlers;

    constructor(Handler[] memory _handlers) {
        handlers = _handlers;
    }

    function sendToFallback(uint handlerIndex, uint amount) public {
        uint index = bound(handlerIndex, 0, handlers.length - 1);
        handlers[index].sendToFallback(amount);
    }

    function deposit(uint handlerIndex, uint amount) public {
        uint index = bound(handlerIndex, 0, handlers.length - 1);
        handlers[index].deposit(amount);
    }

    function withdraw(uint handlerIndex, uint amount) public {
         uint index = bound(handlerIndex, 0, handlers.length - 1);
         handlers[index].withdraw(amount);
    }
}

contract WETH_Multi_Handler_Invariant_Tests is Test {
    WETH public weth;
    Handler[] public handlers;
    ActorManager public manager;
      
    function setUp() public {
          weth = new WETH();

          for(uint i=0;i < 3; i++ ) {
            // for(uint i=0;i < handlers.length; i++ ) {
            handlers.push(new Handler(weth));
            // send 100 eth to each handler
            deal(address(handlers[i]),100*1e18);
          }

          manager = new ActorManager(handlers);
        //   handlers[0] = new Handler(weth);  wrong

        targetContract(address(manager));
    }

    function invariant_eth_balance() public {
        uint total =0 ;
        for (uint i=0; i < handlers.length;i++){
            total += handlers[i].wethBalance();
        }
        console.log("total eth bal",total);
        assertGe(address(weth).balance,total);
    }
}
