// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from "./IERC20.sol";

interface IERC20Snapshot3 is IERC20 {
    function snapshot0BalanceOf(address) external view returns (uint256);

    function snapshot1BalanceOf(address) external view returns (uint256);

    function snapshot2BalanceOf(address) external view returns (uint256);

    function snapshot0() external;

    function snapshot1() external;

    function snapshot2() external;

    function consumeSnapshot0Balance(address) external returns (uint256);

    function consumeSnapshot1Balance(address) external returns (uint256);

    function consumeSnapshot2Balance(address) external returns (uint256);
}
