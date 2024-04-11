// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {setCodeSlot} from "../ERC1967.sol";
import {DistroStage} from "../IDistroStage.sol";
import {IProtocolFund} from "../IProtocolFund.sol";
import {IUpgradable} from "../IUpgradable.sol";
import {amountAddr} from "../amountAddr.sol";
import {console} from "forge-std/console.sol";

contract MockProtocolFundV1 is IProtocolFund, IUpgradable {
    function redeem(amountAddr aaddr) external override {
        (uint256 amount, address redeemer) = aaddr.unpack();
        console.log("MockProtocolFundV1.redeem()", redeemer, amount);

        unchecked {
            uint256 toSendNative = (address(this).balance * amount) / 100_000_000e6;
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
