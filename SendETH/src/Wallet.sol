// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Wallet {
    address payable public owner;
     
     event Deposit(address account, uint256 amount);

     constructor() payable{
        owner = payable(msg.sender);
     }

     receive() external payable {
        emit Deposit(msg.sender, msg.value);
     }

     function withdraw() public {
        require(msg.sender == owner, "caller is not the owner");
        payable(owner).transfer(address(this).balance);
     }
      
      function setOwner(address _owner) public {
        require(msg.sender == owner, "caller is not the owner");
        owner = payable(_owner);
      }

}