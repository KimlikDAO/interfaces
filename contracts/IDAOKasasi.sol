// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./DistroStage.sol";

interface IDAOKasasi {
    function redeem(
        address payable redeemer,
        uint256 burnedTokens,
        uint256 totalTokens
    ) external;

    function distroStageUpdated(DistroStage) external;

    function versionHash() external pure returns (bytes32);

    function migrateToCode(IDAOKasasi codeAddress) external;
}
