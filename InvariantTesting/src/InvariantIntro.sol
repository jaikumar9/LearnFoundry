// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract InvariantIntro {
    bool public flag;

    function func_1() external {}
    function func_2() external {}
    function func_3() external {}
    function func_4() external {}

    function func_5() external {
        flag = true;
    }
}