// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/console.sol";
import {DistroStage} from "../IDistroStage.sol";
import {IProtocolFund, RedeemInfo, REDEEM_INFO_AMOUNT_OFFSET, REDEEM_INFO_SUPPLY_OFFSET} from "../IProtocolFund.sol";
import {IUpgradable} from "../IUpgradable.sol";

contract MockProtocolFundV1 is IProtocolFund, IUpgradable {
    function redeem(RedeemInfo redeemInfo) external {
        uint256 amount = RedeemInfo.unwrap(redeemInfo) >> REDEEM_INFO_AMOUNT_OFFSET;
        uint256 supply = uint48(RedeemInfo.unwrap(redeemInfo) >> REDEEM_INFO_SUPPLY_OFFSET);
        address payable redeemer = payable(address(uint160(RedeemInfo.unwrap(redeemInfo))));
        console.log("MockProtocolFundV1.redeem()", redeemer, amount, supply);
        uint256 toSendNative = (address(this).balance * amount) / supply;
        if (toSendNative > 0) redeemer.transfer(toSendNative);
    }

    function distroStageUpdated(DistroStage stage) external view {
        console.log("MockProtocolFundV1.distroStageUpdated()", uint256(stage));
    }

    function versionHash() external pure returns (bytes32) {
        return 0;
    }

    function migrateToCode(IUpgradable) external {}
}
