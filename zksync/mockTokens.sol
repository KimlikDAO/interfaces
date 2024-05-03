// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20Permit} from "../erc/IERC20Permit.sol";
import {MockERC20Permit} from "../testing/MockERC20Permit.sol";
import {USDT} from "./addresses.sol";
import {Vm} from "forge-std/Vm.sol";

contract USDTImpl is MockERC20Permit {
    function DOMAIN_SEPARATOR() public pure override returns (bytes32) {
        return keccak256(
            abi.encode(
                keccak256(
                    "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
                ),
                keccak256(bytes("KPASS")),
                keccak256(bytes("1")),
                0x144,
                address(USDT)
            )
        );
    }

    function name() public pure returns (string memory) {
        return "Tether";
    }

    function symbol() public pure returns (string memory) {
        return "USDT";
    }

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function initialize() external {
        uint256 toMint = 100 * 10e6;
        balanceOf[msg.sender] = toMint;
        totalSupply = toMint;
        emit Transfer(address(this), msg.sender, toMint);
    }
}

function deployMockTokens() {
    Vm vm = Vm(address(uint160(uint256(keccak256("hevm cheat code")))));

    vm.etch(address(USDT), type(USDTImpl).runtimeCode);
    USDTImpl(address(USDT)).initialize();
}
