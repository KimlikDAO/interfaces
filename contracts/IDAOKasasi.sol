// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./DistroStage.sol";

uint256 constant AMOUNT_OFFSET = 208;

uint256 constant SUPPLY_OFFSET = 160;

interface IDAOKasasi {
    /**
     * Sends amount / supply fraction of all treasury assets to the redeemer.
     *
     *`amountSupplyRedeemer` layout:
     * |-- amount --|-- supply --|--  redeemer --|
     * |--   48   --|--   48   --|--    160    --|
     *
     * @param amountSupplyRedeemer Packed amount, supply, and redeemer.
     */
    function redeem(uint256 amountSupplyRedeemer) external;

    function distroStageUpdated(DistroStage) external;

    function versionHash() external pure returns (bytes32);

    function migrateToCode(IDAOKasasi codeAddress) external;
}
