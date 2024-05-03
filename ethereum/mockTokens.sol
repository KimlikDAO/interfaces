// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20Permit} from "../erc/IERC20Permit.sol";
import {MockERC20, MockERC20Permit} from "../testing/MockERC20Permit.sol";
import {USDT} from "./addresses.sol";
import {Vm} from "forge-std/Vm.sol";

contract USDTImpl is MockERC20 {
    function name() public pure returns (string memory) {
        return "Tether USD";
    }

    function symbol() public pure returns (string memory) {
        return "USDT";
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }
}

address constant USDT_DEPLOYER = 0x36928500Bc1dCd7af6a2B4008875CC336b927D57;

function deployMockTokens() {
    Vm vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    vm.setNonce(USDT_DEPLOYER, 6);
    vm.prank(USDT_DEPLOYER);
    new USDTImpl();
}
