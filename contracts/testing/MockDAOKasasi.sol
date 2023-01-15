// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../IDAOKasasi.sol";
import "forge-std/console.sol";

contract MockDAOKasasi is IDAOKasasi {
    function redeem(uint256 amountSupplyRedeemer) external {
        uint256 amount = amountSupplyRedeemer >> 208;
        uint256 supply = uint48(amountSupplyRedeemer >> 160);
        address payable redeemer = payable(
            address(uint160(amountSupplyRedeemer))
        );
        console.log("MockDAOKasasi.redeem()", redeemer, amount, supply);
        uint256 toSendNative = (address(this).balance * amount) / supply;
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
