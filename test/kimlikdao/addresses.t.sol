// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {
    KDAOL,
    KDAOL_DEPLOYER,
    KDAO_MAINNET,
    KDAO_MAINNET_DEPLOYER,
    KDAO_ZKSYNC,
    KDAO_ZKSYNC_ALIAS,
    KDAO_ZKSYNC_DEPLOYER,
    KPASS,
    KPASS_DEPLOYER,
    KPASS_ZKSYNC,
    KPASS_ZKSYNC_DEPLOYER,
    PROTOCOL_FUND,
    PROTOCOL_FUND_DEPLOYER,
    PROTOCOL_FUND_ZKSYNC,
    PROTOCOL_FUND_ZKSYNC_DEPLOYER
} from "kimlikdao/addresses.sol";
import {applyL1ToL2Alias, computeCreateAddress as computeZkSyncCreateAddress} from "zksync/IZkSync.sol";

contract addressesTest is Test {
    function testDeployerConsistency() public pure {
        assertEq(vm.computeCreateAddress(PROTOCOL_FUND_DEPLOYER, 0), PROTOCOL_FUND);
        assertEq(computeZkSyncCreateAddress(PROTOCOL_FUND_ZKSYNC_DEPLOYER, 0), PROTOCOL_FUND_ZKSYNC);

        assertEq(vm.computeCreateAddress(KPASS_DEPLOYER, 0), KPASS);
        assertEq(computeZkSyncCreateAddress(KPASS_ZKSYNC_DEPLOYER, 0), KPASS_ZKSYNC);

        assertEq(vm.computeCreateAddress(KDAO_MAINNET_DEPLOYER, 0), KDAO_MAINNET);
        assertEq(computeZkSyncCreateAddress(KDAO_ZKSYNC_DEPLOYER, 0), KDAO_ZKSYNC);

        assertEq(computeZkSyncCreateAddress(KDAOL_DEPLOYER, 0), KDAOL);
    }

    function testAliasConsistency() public pure {
        assertEq(applyL1ToL2Alias(KDAO_MAINNET), KDAO_ZKSYNC_ALIAS);
    }
}
