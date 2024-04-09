// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13; 

contract Event {

event Transfer(address indexed from, address indexed to, uint256 value);

function transfer(address from, address to, uint256 value) public {
    emit Transfer(from, to, value);
 }
   
 function transferForMany(address from, address[] memory to, uint256 value) public {
    for (uint i = 0; i < to.length; i++) {
        emit Transfer(from, to[i], value);
 }
}
}