// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/token.sol";

contract TokenScript is Script {

     function setUp() public {
            
     }

     function run()public {

      uint privateKey = vm.envUint("DEV_PRIVATE_KEY");
      address account = vm.addr(privateKey);
      console.log("Deployer Account", account);

        vm.startBroadcast(privateKey);
        //Deploy erc-20 token
         Token token = new Token("Catpuss", "CATP");

        //mint token
        token.mint(account,420000000000000000000);
        vm.stopBroadcast();
     }
    
 }

 // forge script script/token.s.sol:TokenScript --rpc-url $SEPOLIA_RPC_URL --broadcast --verify -vvvv

 // Deployed contract address: 0xdfAA6F65e0948340496E95A6D471D612386B336F