// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {PROTOCOL_FUND} from "../kimlikdao/addresses.sol";
import {uint48x2} from "../types/uint48x2.sol";

type RedeemInfo is uint256;

function RedeemInfoFrom(uint48x2 totalAndAmount, address redeemer) pure returns (RedeemInfo) {
    return RedeemInfo.wrap(uint48x2.unwrap(totalAndAmount) << 160 | uint160(redeemer));
}

function unpack(RedeemInfo self) pure returns (uint256 total, uint256 redeemed, address redeemer) {
    uint256 val = RedeemInfo.unwrap(self);
    return (val >> 208, uint48(val >> 160), address(uint160(val)));
}

using {unpack} for RedeemInfo global;

interface IProtocolFund {
    /**
     * @param redeemInfo the packed struct containing redeemed amount and the redeemer address.
     */
    function redeem(RedeemInfo redeemInfo) external;
}

IProtocolFund constant ProtocolFund = IProtocolFund(PROTOCOL_FUND);
