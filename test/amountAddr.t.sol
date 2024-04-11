// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {amountAddr, amountAddrFrom} from "contracts/amountAddr.sol";

contract amountAddrTest is Test {
    function testAccessors() public pure {
        amountAddr aaddr = amountAddrFrom(1, address(0x1337ACC));

        assertEq(aaddr.addr(), address(0x1337ACC));
        assertEq(aaddr.amount(), 1);
    }
}
