// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/token.sol";

contract TokenScript is Script {

     function setUp() public {
            
     }

     function run()public {
        vm.startBroadcast();
        //Deploy erc-20 token
          
         Token token = new Token("Catpuss", "CATP");

        //mint token

        token.mint(msg.sender,420000000000000000000);
        
        vm.stopBroadcast();
     }
    
 }