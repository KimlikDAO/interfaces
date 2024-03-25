// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

uint256 constant REDEEM_INFO_AMOUNT_OFFSET = 208;

uint256 constant REDEEM_INFO_SUPPLY_OFFSET = 160;

/**
 * `RedeemInfo` layout
 * |-- amount --|-- supply --|--  redeemer --|
 * |--   48   --|--   48   --|--    160    --|
 */
type RedeemInfo is uint256;

interface IProtocolFund {
    /**
     * @param redeemInfo the packed struct containing redeemed amount out of the
     *                   total supply and the redeemer address.
     *
     * In the signal chain `ProtocolFund`, the method completes the asset transfer
     * atomically. The remote `ProtocolFund`
     *
     */
    function redeem(RedeemInfo redeemInfo) external;
}
