// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {setCodeSlot} from "../erc/ERC1967.sol";
import {DistroStage} from "../kimlikdao/IDistroStage.sol";
import {IProtocolFund, RedeemInfo} from "../kimlikdao/IProtocolFund.sol";
import {IUpgradable} from "../kimlikdao/IUpgradable.sol";
import {console} from "forge-std/console.sol";

contract MockProtocolFundV1 is IProtocolFund, IUpgradable {
    function redeem(RedeemInfo redeemInfo) external override {
        (uint256 total, uint256 amount, address redeemer) = redeemInfo.unpack();
        console.log("MockProtocolFundV1.redeem()", redeemer, amount, total);

        unchecked {
            uint256 toSendNative = (address(this).balance * amount) / total;
            if (toSendNative > 0) payable(redeemer).transfer(toSendNative);
        }
    }

    function versionHash() external pure override returns (bytes32) {
        return keccak256("MockProtocolFundV1");
    }

    function updateCodeTo(IUpgradable code) external override {
        require(code.versionHash() == keccak256("MockProtocolFundV2"));
        setCodeSlot(address(code));
    }
}
