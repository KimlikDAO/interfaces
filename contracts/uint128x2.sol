// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

type uint128x2 is uint256;

function uint128x2From(uint256 hi, uint256 lo) pure returns (uint128x2) {
    return uint128x2.wrap(hi << 128 | lo);
}

function hi128(uint128x2 n) pure returns (uint256) {
    return uint128x2.unwrap(n) >> 128;
}

function lo128(uint128x2 n) pure returns (uint256) {
    return uint128(uint128x2.unwrap(n));
}

function decLo(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) - delta);
    }
}

function inc(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) + (delta | delta << 128));
    }
}

function dec(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) - (delta | delta << 128));
    }
}

using {hi128, lo128, decLo, inc, dec} for uint128x2 global;
