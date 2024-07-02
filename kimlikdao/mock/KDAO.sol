// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {ERC20Permit as MockERC20Permit} from "../../erc/mock/ERC20Permit.sol";

contract KDAO is MockERC20Permit {
    function name() external pure override returns (string memory) {
        return "KimlikDAO";
    }

    function symbol() external pure override returns (string memory) {
        return "KDAO";
    }

    function decimals() external pure override returns (uint8) {
        return 6;
    }

    function DOMAIN_SEPARATOR() public pure override returns (bytes32) {
        return 0;
    }
}
