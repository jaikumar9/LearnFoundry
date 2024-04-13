// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/ERC20Permit.sol";
import "../src/GasLessTokenTransfer.sol";

contract GasLessTokenTransferTest is Test {
    ERC20Permit private token;
    GasLessTokenTransfer private gasless;

    uint constant SENDER_PRIVATE_KEY = 42069;
    address sender;
    address receiver;
    uint constant AMOUNT = 420;
    uint constant FEE = 69;

    function setUp() public {
        sender = vm.addr(SENDER_PRIVATE_KEY);
        receiver = address(2);
        token = new ERC20Permit("testToken", "test", 18);
        token.mint(sender, AMOUNT + FEE);
        gasless = new GasLessTokenTransfer();
    }

    function testValidSign() public {
        // perpare permit message
        uint deadline = block.timestamp + 60;

        bytes32 PermitHash = _getPermitHash(
            sender,
            address(gasless),
            uint(AMOUNT + FEE),
            token.nonces(sender),
            deadline
        );

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(
            SENDER_PRIVATE_KEY,
            PermitHash
        );

        // Execute send
        gasless.send(address(token),sender,receiver,AMOUNT,FEE,deadline,v,r,s);

        // check token balances
        assertEq(token.balanceOf(sender), 0, "Sender Balance");
        assertEq(token.balanceOf(receiver), AMOUNT, "Receivers Contract Balance Balance");
        assertEq(token.balanceOf(address(this)), FEE, "Test contract Gets Fees Balance");
    }

    function _getPermitHash(
        address owner,
        address spender,
        uint value,
        uint nonce,
        uint deadline
    ) private view returns (bytes32) {
        return
            keccak256(
                abi.encodePacked(
                    "\x19\x01",
                    token.DOMAIN_SEPARATOR(),
                    keccak256(
                        abi.encode(
                            keccak256(
                                "Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"
                            ),
                            owner,
                            spender,
                            value,
                            nonce,
                            deadline
                        )
                    )
                )
            );
    }
}
