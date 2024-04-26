// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20Permit} from "../erc/IERC20Permit.sol";
import {MockERC20Permit} from "../testing/MockERC20Permit.sol";
import {Vm} from "forge-std/Vm.sol";
import {console2} from "forge-std/console2.sol";

address constant USDT_DEPLOYER = 0x493257fD37EDB34451f62EDf8D2a0C418852bA4C;

function deployMockTokens() {
    Vm vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    vm.setNonce(USDT_DEPLOYER, 4);
    vm.prank(USDT_DEPLOYER);
    IERC20Permit usdc = new MockERC20Permit("USDC", "USD Coin", 6);
    console2.log("USDC:", address(usdc));
}
