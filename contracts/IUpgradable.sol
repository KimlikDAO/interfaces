// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IUpgradable {
    function versionHash() external pure returns (bytes32);

    function migrateToCode(IUpgradable codeAddress) external;
}
