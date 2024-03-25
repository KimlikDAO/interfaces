// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

bytes32 constant CREATE_PREFIX = 0x63bae3a9951d38e8a3fbb7b70909afc1200610fc5bc55ade242f815974674f23;

function computeCreateAddress(address deployer, uint256 nonce) pure returns (address) {
    bytes32 hash = keccak256(bytes.concat(CREATE_PREFIX, bytes32(uint256(uint160(deployer))), bytes32(nonce)));
    return address(uint160(uint256(hash)));
}
