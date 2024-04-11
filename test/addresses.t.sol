// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {
    PROTOCOL_FUND,
    PROTOCOL_FUND_DEPLOYER,
    PROTOCOL_FUND_ZKSYNC,
    PROTOCOL_FUND_ZKSYNC_DEPLOYER,
    KPASS_DEPLOYER,
    KPASS,
    KPASS_ZKSYNC,
    KPASS_ZKSYNC_DEPLOYER,
    KDAO_MAINNET,
    KDAO_MAINNET_DEPLOYER,
    KDAO_ZKSYNC,
    KDAO_ZKSYNC_DEPLOYER,
    KDAO_ZKSYNC_ALIAS,
    KDAOL,
    KDAOL_DEPLOYER
} from "contracts/Addresses.sol";
import {Test} from "forge-std/Test.sol";
import {computeCreateAddress as computeZkSyncCreateAddress, applyL1ToL2Alias} from "contracts/IZkSync.sol";

contract AddressesTest is Test {
    function testDeployerConsistency() public pure {
        assertEq(computeCreateAddress(PROTOCOL_FUND_DEPLOYER, 0), PROTOCOL_FUND);
        assertEq(computeZkSyncCreateAddress(PROTOCOL_FUND_ZKSYNC_DEPLOYER, 0), PROTOCOL_FUND_ZKSYNC);

        assertEq(computeCreateAddress(KPASS_DEPLOYER, 0), KPASS);
        assertEq(computeZkSyncCreateAddress(KPASS_ZKSYNC_DEPLOYER, 0), KPASS_ZKSYNC);

        assertEq(computeCreateAddress(KDAO_MAINNET_DEPLOYER, 0), KDAO_MAINNET);
        assertEq(computeZkSyncCreateAddress(KDAO_ZKSYNC_DEPLOYER, 0), KDAO_ZKSYNC);
        assertEq(applyL1ToL2Alias(KDAO_MAINNET), KDAO_ZKSYNC_ALIAS);

        assertEq(computeZkSyncCreateAddress(KDAOL_DEPLOYER, 0), KDAOL);
    }
}
