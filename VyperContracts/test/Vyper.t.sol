 // SPDX-License-Identifier: UNLICENSED
 pragma solidity 0.8.20;

import "forge-std/Test.sol";
import "../lib/utiles/VyperDeployer.sol";
import "../src/IVyperStorage.sol";

// source venv/bin/activate
// forge test --match-path test/Vyper.t.sol --ffi

contract VyperStorageTest is Test {
    VyperDeployer vyperDeployer = new VyperDeployer();
    IVyperStorage internal vyperStorage;

    function setUp() public {
        vyperStorage = IVyperStorage(
            vyperDeployer.deployContract("VyperStorage", abi.encode(420))
        );

        targetContract(address(vyperStorage));
    }

     function testGet() public {
        uint256 val = vyperStorage.get();
        assertEq(val, 420);
    }

    function testStore(uint256 val) public{
        vyperStorage.store(val);
        assertEq(vyperStorage.get(), val);

    }

      function invariant_test() public {
        assertTrue(true);
    }


}