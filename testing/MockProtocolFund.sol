// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {CODE_SLOT, setCodeSlot} from "../erc/ERC1967.sol";

contract MockProtocolFund {
    constructor() {
        setCodeSlot(0x4DB9cbE44bF9B747Cd3F3fEfEFbfDb2f2DaA8Cf5);
    }

    receive() external payable {}

    fallback() external payable {
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), sload(CODE_SLOT), 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}
