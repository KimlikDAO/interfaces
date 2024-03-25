// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {CODE_SLOT} from "../ERC1967.sol";

contract MockProtocolFund {
    constructor() {
        assembly {
            sstore(CODE_SLOT, 0x4DB9cbE44bF9B747Cd3F3fEfEFbfDb2f2DaA8Cf5)
        }
    }

    receive() external payable {}

    fallback() external payable {
        assembly {
            let codeAddress := sload(CODE_SLOT)
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), codeAddress, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}
