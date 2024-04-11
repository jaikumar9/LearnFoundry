// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

//prerequiesr Learn about ecrecover first.
contract SignTest is Test {
    // private key =123
    // public key = vm.addr(private key)
    //message = "Secret message"
    //message hash = keccak256(message)
    // vm.sign(private key, message hash)

    function testSignature() public {
        uint privateKey = 42069;

        address publicKey = vm.addr(privateKey);

        bytes32 messageHash = keccak256("MFS lit a Joint");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        address signer = ecrecover(messageHash, v, r, s);

        assertEq(publicKey, signer);
    }

    function testFailSignature() public {
        uint privateKey = 42069;
        uint privateKey1 = 6342069;

        address publicKey = vm.addr(privateKey);
        address publicKey1 = vm.addr(privateKey1);

        bytes32 messageHash = keccak256("MFS lit a Joint");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        address signer = ecrecover(messageHash, v, r, s);

        assertEq(publicKey1, signer);
    }

      function testSignatureDiffSign()public {
        uint privateKey = 42069;
        
        address publicKey = vm.addr(privateKey);
        
         bytes32 messageHash = keccak256("MFS lit a Joint");

         (uint8 v, bytes32 r, bytes32 s)= vm.sign(privateKey,messageHash);

         address signer = ecrecover(messageHash,v,r,s);

         assertEq(publicKey, signer);
         

         bytes32 AnotherJoint = keccak256("MFS lit an another Joint");
         signer = ecrecover(AnotherJoint,v,r,s);

           assertTrue(signer != publicKey );
      }
}
