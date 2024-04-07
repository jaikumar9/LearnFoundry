// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "solmate/tokens/ERC20.sol";
// We are creating a contract "TestToken" from 
// the ERC20 contract that we imported.

contract TestToken is ERC20 {

    constructor() ERC20("TestToken", "TST", 18) {
        _mint(msg.sender, 100000000000000000000000000);
    }
 }

import "@openzeppelin/contracts/access/Ownable.sol";

 contract TestOz is Ownable {
    constructor() Ownable(0x53771dd19E60d3Cadb0d2469A203D14A7F69b1a9){}
}