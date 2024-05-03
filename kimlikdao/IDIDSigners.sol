// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Signature} from "../types/Signature.sol";
import {uint128x2} from "../types/uint128x2.sol";

interface IDIDSigners {
    function authenticateHumanIDv1(
        bytes32 exposureReportID,
        uint128x2 weightThresholdAndSignatureTs,
        bytes32 commitmentR,
        Signature[3] calldata sigs
    ) external view returns (bool);

    function authenticateHumanIDv1(
        bytes32 humanID,
        uint128x2 weightThresholdAndSignatureTs,
        bytes32 commitmentR,
        Signature[5] calldata sigs
    ) external view returns (bool);

    /**
     * Maps a signer node address to a bit packed struct.
     */
    function signerInfo(address signer) external view returns (SignerInfo);
}

interface IDIDSignersExposureReport {
    function reportExposure(
        bytes32 exposureReportID,
        uint256 signatureTs,
        Signature[3] calldata sigs
    ) external;
}

uint256 constant SIGNER_INFO_END_TS_MASK = uint256(type(uint64).max) << 112;

uint256 constant SIGNER_INFO_WITHDRAW_MASK = uint256(type(uint48).max) << 176;

/**
 * `signerInfo` layout:
 * |-- color --|-- withdraw --|--  endTs --|-- deposit --|-- startTs --|
 * |--   32  --|--    48    --|--   64   --|--   48    --|--   64    --|
 */
type SignerInfo is uint256;

function SignerInfoFrom(uint256 _color, uint256 _deposit, uint256 _startTs)
    pure
    returns (SignerInfo)
{
    return SignerInfo.wrap((_color << 224) | (_deposit << 64) | _startTs);
}

function deposit(SignerInfo self) pure returns (uint256) {
    return uint48(SignerInfo.unwrap(self) >> 64);
}

function startTs(SignerInfo self) pure returns (uint256) {
    return uint64(SignerInfo.unwrap(self));
}

function endTs(SignerInfo self) pure returns (uint256) {
    return uint64(SignerInfo.unwrap(self) >> 112);
}

function hasEndTs(SignerInfo self) pure returns (bool) {
    return (SignerInfo.unwrap(self) & SIGNER_INFO_END_TS_MASK) != 0;
}

function addEndTs(SignerInfo self, uint256 _endTs) pure returns (SignerInfo) {
    return SignerInfo.wrap(SignerInfo.unwrap(self) | (_endTs << 112));
}

function withdraw(SignerInfo self) pure returns (uint256) {
    return uint48(SignerInfo.unwrap(self) >> 176);
}

function addWithdraw(SignerInfo self, uint256 _withdraw) pure returns (SignerInfo) {
    return SignerInfo.wrap(SignerInfo.unwrap(self) | (_withdraw << 176));
}

function clearWithdraw(SignerInfo self) pure returns (SignerInfo) {
    return SignerInfo.wrap(SignerInfo.unwrap(self) & ~SIGNER_INFO_WITHDRAW_MASK);
}

function color(SignerInfo self) pure returns (uint256) {
    return SignerInfo.unwrap(self) >> 224;
}

function isZero(SignerInfo self) pure returns (bool) {
    return SignerInfo.unwrap(self) == 0;
}

using {
    color,
    withdraw,
    addWithdraw,
    clearWithdraw,
    endTs,
    addEndTs,
    deposit,
    startTs,
    hasEndTs,
    isZero
} for SignerInfo global;
