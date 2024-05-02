// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {exp} from "../src/Exp.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract DifferentialTest is Test {
    using Strings for uint256;

    function ffi_exp(int128 x) private returns (int128) {
        string[] memory inputs = new string[](3);
        inputs[0] = "python";
        inputs[1] = "exp.py";
        inputs[2] = uint256(int256(x)).toString(); // Assuming int256(x).toString() converts int256 to string
        bytes memory res = vm.ffi(inputs);
        // console.log(string(res));

        int128 y = abi.decode(res, (int128));

        return y;
    }

    function test_exp(int128 x) public {
        vm.assume(x >= 2**64);
        vm.assume(x <= 20*2**64);

        int128 y0 = ffi_exp(x);
        int128 y1 = exp(x);

        // Check |y0 - y1| <= 1 = 2** 64
        uint256 DELTA = 2 ** 64;
        
         assertApproxEqAbs(uint256(int256(y0)), uint256(int256(y1)), DELTA); //
            // assertApproxEqAbs are always in the positive.
            // assertApproxEqAbs function is used to assert that a 
            // given value left is approximately equal to another value right,
            // with a maximum allowed difference specified by maxDelta
    }

    // $ FOUNDRY_FUZZ_RUNS=200 forge test --match-path test/DifferentialTest.t.sol --ffi -vvv
}
