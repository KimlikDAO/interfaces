// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

type amountAddr is uint256;

function amountAddrFrom(uint256 _amount, address _addr) pure returns (amountAddr) {
    return amountAddr.wrap(_amount << 160 | uint160(_addr));
}

function unpack(amountAddr self) pure returns (uint256, address) {
    return (amountAddr.unwrap(self) >> 160, address(uint160(amountAddr.unwrap(self))));
}

function amount(amountAddr self) pure returns (uint256) {
    return amountAddr.unwrap(self) >> 160;
}

function addr(amountAddr self) pure returns (address) {
    return address(uint160(amountAddr.unwrap(self)));
}

function notEqual(amountAddr self, amountAddr other) pure returns (bool) {
    return amountAddr.unwrap(self) != amountAddr.unwrap(other);
}

using {unpack, amount, addr, notEqual as !=} for amountAddr global;
