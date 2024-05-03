// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {
    TRYB, TRYB_DEPLOYER, USDC, USDC_DEPLOYER, USDT, USDT_DEPLOYER
} from "avalanche/addresses.sol";
import {Test} from "forge-std/Test.sol";

contract addressesTest is Test {
    function testDeployerConsistency() external pure {
        assertEq(vm.computeCreateAddress(TRYB_DEPLOYER, 2), address(TRYB));
        assertEq(vm.computeCreateAddress(USDC_DEPLOYER, 4), address(USDC));
        assertEq(vm.computeCreateAddress(USDT_DEPLOYER, 2), address(USDT));
    }
}
