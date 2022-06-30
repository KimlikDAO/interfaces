//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC20Permit.sol";
import {TCKO_ADDR} from "./Addresses.sol";

IERC20 constant TRYB = IERC20(0x564A341Df6C126f90cf3ECB92120FD7190ACb401);

IERC20Permit constant TCKO = IERC20Permit(TCKO_ADDR);

IERC20Permit constant USDC = IERC20Permit(
    0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E
);

IERC20Permit constant USDT = IERC20Permit(
    0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7
);

IERC20Permit constant FRAX = IERC20Permit(
    0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64
);

IERC20Permit constant USDD = IERC20Permit(
    0xcf799767d366d789e8B446981C2D578E241fa25c
);

IERC20Permit constant MIM = IERC20Permit(
    0x130966628846BFd36ff31a822705796e8cb8C18D
);
