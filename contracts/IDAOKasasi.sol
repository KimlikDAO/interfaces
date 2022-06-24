// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./DistroStage.sol";

// bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1)
bytes32 constant ERC1967_CODE_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

interface IDAOKasasi {
    function redeem(
        address payable redeemer,
        uint256 burnedTokens,
        uint256 totalTokens
    ) external;

    function distroStageUpdated(DistroStage) external;

    function versionHash() external pure returns (bytes32);

    function migrateToCode(address codeAddress) external;
}
