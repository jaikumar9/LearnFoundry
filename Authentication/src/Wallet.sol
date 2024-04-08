// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Wallet {
  
  address payable public owner;

  constructor() payable {
    owner = payable(msg.sender);
  }
 
   receive() external payable {}

  function withdraw(uint256 _amount) public {
    require((msg.sender == owner),"Only owner can withdraw");
    payable(msg.sender).transfer(_amount);
  }
  
  function setOwner(address _owner) public {
    require((msg.sender == owner),"Only owner can set owner");
    owner = payable(_owner);
}
}