// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {
    KDAO,
    KDAO_DEPLOYER,
    KDAO_LOCKED,
    KDAO_LOCKED_DEPLOYER,
    KPASS,
    KPASS_DEPLOYER,
    KPASS_ZKSYNC,
    KPASS_ZKSYNC_DEPLOYER
} from "../addresses.sol";
import {
    applyL1ToL2Alias,
    computeCreateAddress as computeZkSyncCreateAddress
} from "../../zksync/IZkSync.sol";

contract addressesTest is Test {
    function testDeployerConsistency() public pure {
        assertEq(vm.computeCreateAddress(KPASS_DEPLOYER, 0), KPASS);
        assertEq(computeZkSyncCreateAddress(KPASS_ZKSYNC_DEPLOYER, 0), KPASS_ZKSYNC);

        assertEq(vm.computeCreateAddress(KDAO_DEPLOYER, 0), KDAO);
        assertEq(vm.computeCreateAddress(KDAO_LOCKED_DEPLOYER, 0), KDAO_LOCKED);
    }
}
