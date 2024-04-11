// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

type uint128x2 is uint256;

function uint128x2From(uint256 high, uint256 low) pure returns (uint128x2) {
    return uint128x2.wrap(high << 128 | low);
}

function hi(uint128x2 n) pure returns (uint256) {
    return uint128x2.unwrap(n) >> 128;
}

function lo(uint128x2 n) pure returns (uint256) {
    return uint128(uint128x2.unwrap(n));
}

function decLo(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) - delta);
    }
}

function inc(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) + (delta | (delta << 128)));
    }
}

function dec(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) - (delta | (delta << 128)));
    }
}

function equal(uint128x2 self, uint128x2 other) pure returns (bool) {
    return uint128x2.unwrap(self) == uint128x2.unwrap(other);
}

using {hi, lo, decLo, inc, dec, equal as ==} for uint128x2 global;