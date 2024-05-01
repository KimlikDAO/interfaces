// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {L2LogLocator, L2LogLocatorFrom} from "zksync/L2Log.sol";

contract L2LogLocatorTest is Test {
    function testAccessors() external pure {
        L2LogLocator l = L2LogLocatorFrom(1, 2, 3);
        assertEq(l.batchNumber(), 1);
        assertEq(l.messageIndex(), 2);
        assertEq(l.txNumber(), 3);

        L2LogLocator k = L2LogLocatorFrom(type(uint128).max, type(uint112).max, type(uint16).max);
        assertEq(k.batchNumber(), type(uint128).max);
        assertEq(k.messageIndex(), type(uint112).max);
        assertEq(k.txNumber(), type(uint16).max);

        L2LogLocator m = L2LogLocatorFrom(type(uint128).max - 1, type(uint112).max - 1, type(uint16).max - 1);
        assertEq(m.batchNumber(), type(uint128).max - 1);
        assertEq(m.messageIndex(), type(uint112).max - 1);
        assertEq(m.txNumber(), type(uint16).max - 1);
    }
}
