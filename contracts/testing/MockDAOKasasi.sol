// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../IDAOKasasi.sol";
import "forge-std/console.sol";

contract MockDAOKasasi is IDAOKasasi {
    function redeem(
        address payable redeemer,
        uint256 amount,
        uint256 totalSupply
    ) external {
        console.log("MockDAOKasasi.redeem()", redeemer, amount, totalSupply);
        uint256 toSendNative = (address(this).balance * amount) / totalSupply;
        if (toSendNative > 0) redeemer.transfer(toSendNative);
    }

    function distroStageUpdated(DistroStage stage) external view {
        console.log("MockDAOKasasi.distroStageUpdated()", uint256(stage));
    }

    function versionHash() external pure returns (bytes32) {
        return 0;
    }

    function migrateToCode(IDAOKasasi) external {}
}
