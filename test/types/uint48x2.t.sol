// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {uint48x2, uint48x2From} from "types/uint48x2.sol";

contract uint48x2Test is Test {
    function testAccessors() external pure {
        uint48x2 pair = uint48x2From(1, 2);

        assertEq(pair.lo(), 2);
        assertEq(pair.hi(), 1);
    }

    function testIncDec() external pure {
        uint48x2 pair = uint48x2From(300, 500);
        pair = pair.inc(200);

        assertEq(pair.hi(), 500);
        assertEq(pair.lo(), 700);

        pair = pair.dec(200);

        assertEq(pair.hi(), 300);
        assertEq(pair.lo(), 500);

        uint48x2 pair2 = uint48x2From(type(uint48).max, 10);
        uint48x2 pair3 = pair2.dec(10);
        pair3 = pair3.inc(10);

        assert(pair2 == pair3);
    }

    function tesetClear() external pure {
        uint48x2 i = uint48x2From(2, 1);

        i = i.clearHi();
        assertEq(i.hi(), 0);
        assertEq(i.lo(), 1);

        uint48x2 j = uint48x2From(3, 2);

        j = j.clearLo();
        j = j.clearLo();
        assertEq(j.hi(), 3);
        assertEq(j.lo(), 0);
    }

    function testSum() external pure {
        uint48x2 i = uint48x2From(type(uint48).max - 1, 1);

        assertEq(i.sum(), type(uint48).max);
        assertEq(uint48x2From(1, 2).sum(), 3);
        assertEq(uint48x2From(2, 3).sum(), 5);
        assertEq(uint48x2From(1337, 1338).sum(), 2 * 1337 + 1);
    }

    function testSetLo() external pure {
        uint48x2 i = uint48x2From(2, 3);

        assertEq(i.setLo(4).hi(), 2);
        assertEq(i.setLo(4).lo(), 4);
    }

    function testClearLo() external pure {
        uint48x2 n = uint48x2From(3, 2).clearLo();

        assertEq(n.hi(), 3);
        assertEq(n.lo(), 0);
    }

    function testClearHi() external pure {
        uint48x2 n = uint48x2From(3, 2).clearHi();

        assertEq(n.hi(), 0);
        assertEq(n.lo(), 2);
    }
}
