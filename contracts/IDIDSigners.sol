// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

type uint128x2 is uint256;

struct Signature {
    bytes32 r;
    uint256 yParityAndS;
}

uint256 constant SIGNER_INFO_DEPOSIT_OFFSET = 64;

uint256 constant SIGNER_INFO_END_TS_OFFSET = 112;

uint256 constant SIGNER_INFO_END_TS_MASK = uint256(type(uint64).max) << 112;

uint256 constant SIGNER_INFO_WITHDRAW_OFFSET = 176;

uint256 constant SIGNER_INFO_WITHDRAW_MASK = uint256(type(uint48).max) << 176;

/**
 *
 * `signerInfo` layout:
 * |-- color --|-- withdraw --|--  endTs --|-- deposit --|-- startTs --|
 * |--   32  --|--    48    --|--   64   --|--   48    --|--   64    --|
 */
type SignerInfo is uint256;

interface IDIDSigners {
    function authenticateExposureReportID3Sigs(
        bytes32 exposureReportID,
        uint128x2 weightThresholdAndSignatureTs,
        Signature[3] calldata sigs
    ) external view;

    function authenticateHumanID3Sigs(
        bytes32 exposureReportID,
        uint128x2 weightThresholdAndSignatureTs,
        bytes32 commitmentR,
        Signature[3] calldata sigs
    ) external view;

    function authenticateHumanID5Sigs(
        bytes32 humanID,
        uint128x2 weightThresholdAndSignatureTs,
        bytes32 commitmentR,
        Signature[5] calldata sigs
    ) external view;

    /**
     * Maps a signer node address to a bit packed struct.
     */
    function signerInfo(address signer) external view returns (SignerInfo);
}
