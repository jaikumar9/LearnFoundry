// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

interface IVyperStorage {

function store(uint256) external;
function get() external view returns (uint256);

}