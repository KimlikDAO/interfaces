// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

type YParityAndS is uint256;

function yParity(YParityAndS self) pure returns (uint8) {
    unchecked {
        return uint8((YParityAndS.unwrap(self) >> 255) + 27);
    }
}

function s(YParityAndS self) pure returns (bytes32) {
    unchecked {
        return bytes32(YParityAndS.unwrap(self) & ((1 << 255) - 1));
    }
}

using {yParity, s} for YParityAndS global;

struct Signature {
    bytes32 r;
    YParityAndS yParityAndS;
}
