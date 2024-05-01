// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {uint128x2, uint128x2From} from "types/uint128x2.sol";

contract uint128x2Test is Test {
    function testAccessors() external pure {
        uint128x2 pair = uint128x2From(1, 2);

        assertEq(pair.lo(), 2);
        assertEq(pair.hi(), 1);
    }

    function testIncDec() external pure {
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

    function tesetClear() external pure {
        uint128x2 i = uint128x2From(2, 1);

        i = i.clearHi();
        assertEq(i.hi(), 0);
        assertEq(i.lo(), 1);

        uint128x2 j = uint128x2From(3, 2);

        j = j.clearLo();
        j = j.clearLo();
        assertEq(j.hi(), 3);
        assertEq(j.lo(), 0);
    }

    function testSum() external pure {
        uint128x2 i = uint128x2From(type(uint128).max - 1, 1);

        assertEq(i.sum(), type(uint128).max);
        assertEq(uint128x2From(1, 2).sum(), 3);
        assertEq(uint128x2From(2, 3).sum(), 5);
        assertEq(uint128x2From(1337, 1338).sum(), 2 * 1337 + 1);
    }

    function testClearLo() external pure {
        uint128x2 n = uint128x2From(2, 1);
        n = n.clearLo();

        assertEq(n.hi(), 2);
        assertEq(n.lo(), 0);
    }

    function testClearHi() external pure {
        uint128x2 n = uint128x2From(100, 50);
        n = n.clearHi();

        assertEq(n.hi(), 0);
        assertEq(n.lo(), 50);
    }
}
