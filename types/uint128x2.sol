// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

type uint128x2 is uint256;

function uint128x2From(uint256 high, uint256 low) pure returns (uint128x2) {
    return uint128x2.wrap(high << 128 | low);
}

function hi(uint128x2 self) pure returns (uint256) {
    return uint128x2.unwrap(self) >> 128;
}

function lo(uint128x2 self) pure returns (uint256) {
    return uint128(uint128x2.unwrap(self));
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

function incHi(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) + (delta << 128));
    }
}

function incLo(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) + delta);
    }
}

function decHi(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) - (delta << 128));
    }
}

function decLo(uint128x2 self, uint256 delta) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) - delta);
    }
}

function setLo(uint128x2 self, uint256 val) pure returns (uint128x2) {
    return uint128x2.wrap((uint128x2.unwrap(self) & (~uint256(0) << 128)) | val);
}

function sum(uint128x2 self) pure returns (uint256) {
    unchecked {
        return (uint128x2.unwrap(self) >> 128) + uint128(uint128x2.unwrap(self));
    }
}

function clearLo(uint128x2 self) pure returns (uint128x2) {
    return uint128x2.wrap(uint128x2.unwrap(self) & (~uint256(0) << 128));
}

function clearHi(uint128x2 self) pure returns (uint128x2) {
    return uint128x2.wrap(uint128x2.unwrap(self) & (~uint256(0) >> 128));
}

function equal(uint128x2 self, uint128x2 other) pure returns (bool) {
    return uint128x2.unwrap(self) == uint128x2.unwrap(other);
}

/**
 * Given a fraction (hi, lo) and a value val, computes the tuple (val * hi / lo, val) efficiently.
 *
 * @return (val * hi / lo, val)
 */
function fracMul(uint128x2 self, uint256 val) pure returns (uint128x2) {
    unchecked {
        return uint128x2.wrap(uint128x2.unwrap(self) * val / uint128(uint128x2.unwrap(self))).setLo(val);
    }
}

using {
    hi,
    lo,
    inc,
    dec,
    incHi,
    incLo,
    decHi,
    decLo,
    setLo,
    sum,
    clearHi,
    clearLo,
    fracMul,
    equal as ==
} for uint128x2 global;
