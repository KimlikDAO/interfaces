// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {uint128x2, uint128x2From} from "contracts/uint128x2.sol";
import {Test} from "forge-std/Test.sol";

contract uint128x2Test is Test {
    function testAccessors() public pure {
        uint128x2 pair = uint128x2From(1, 2);

        assertEq(pair.lo(), 2);
        assertEq(pair.hi(), 1);
    }

    function testIncDec() public pure {
        uint128x2 pair = uint128x2From(300, 500);
        pair = pair.inc(200);

        assertEq(pair.hi(), 500);
        assertEq(pair.lo(), 700);

        pair = pair.dec(200);

        assertEq(pair.hi(), 300);
        assertEq(pair.lo(), 500);

        uint128x2 pair2 = uint128x2From(type(uint128).max, 10);
        uint128x2 pair3 = pair2.dec(10);
        pair3 = pair3.inc(10);

        assert(pair2 == pair3);
    }
}
