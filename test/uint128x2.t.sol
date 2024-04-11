// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {uint128x2, uint128x2From} from "contracts/uint128x2.sol";

contract integersTest is Test {
    function testAccessors() public pure {
        uint128x2 pair = uint128x2From(1, 2);

        assertEq(pair.lo128(), 2);
        assertEq(pair.hi128(), 1);
    }
}
