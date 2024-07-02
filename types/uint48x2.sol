// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

type uint48x2 is uint256;

function uint48x2From(uint256 high, uint256 low) pure returns (uint48x2) {
    return uint48x2.wrap(high << 48 | low);
}

function hi(uint48x2 self) pure returns (uint256) {
    return uint48x2.unwrap(self) >> 48;
}

function lo(uint48x2 self) pure returns (uint256) {
    return uint48(uint48x2.unwrap(self));
}

function inc(uint48x2 self, uint256 delta) pure returns (uint48x2) {
    unchecked {
        return uint48x2.wrap(uint48x2.unwrap(self) + (delta | (delta << 48)));
    }
}

function dec(uint48x2 self, uint256 delta) pure returns (uint48x2) {
    unchecked {
        return uint48x2.wrap(uint48x2.unwrap(self) - (delta | (delta << 48)));
    }
}

function incHi(uint48x2 self, uint256 delta) pure returns (uint48x2) {
    unchecked {
        return uint48x2.wrap(uint48x2.unwrap(self) + (delta << 48));
    }
}

function incLo(uint48x2 self, uint256 delta) pure returns (uint48x2) {
    unchecked {
        return uint48x2.wrap(uint48x2.unwrap(self) + delta);
    }
}

uint256 constant HI_MASK = uint256(type(uint48).max) << 48;

function setLo(uint48x2 self, uint256 val) pure returns (uint48x2) {
    return uint48x2.wrap((uint48x2.unwrap(self) & HI_MASK) | val);
}

function decHi(uint48x2 self, uint256 delta) pure returns (uint48x2) {
    unchecked {
        return uint48x2.wrap(uint48x2.unwrap(self) - (delta << 48));
    }
}

function decLo(uint48x2 self, uint256 delta) pure returns (uint48x2) {
    unchecked {
        return uint48x2.wrap(uint48x2.unwrap(self) - delta);
    }
}

function sum(uint48x2 self) pure returns (uint256) {
    unchecked {
        return (uint48x2.unwrap(self) >> 48) + uint48(uint48x2.unwrap(self));
    }
}

function clearLo(uint48x2 self) pure returns (uint48x2) {
    return uint48x2.wrap(uint48x2.unwrap(self) & (~uint256(0) << 48));
}

function clearHi(uint48x2 self) pure returns (uint48x2) {
    return uint48x2.wrap(uint48x2.unwrap(self) & (~uint256(0) >> 208));
}

function equal(uint48x2 self, uint48x2 other) pure returns (bool) {
    return uint48x2.unwrap(self) == uint48x2.unwrap(other);
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
    equal as ==
} for uint48x2 global;
