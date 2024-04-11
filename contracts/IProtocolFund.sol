// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {PROTOCOL_FUND} from "./addresses.sol";
import {amountAddr} from "./amountAddr.sol";

interface IProtocolFund {
    /**
     * @param redeemer the packed struct containing redeemed amount and the redeemer address.
     */
    function redeem(amountAddr redeemer) external;
}

IProtocolFund constant ProtocolFund = IProtocolFund(PROTOCOL_FUND);
