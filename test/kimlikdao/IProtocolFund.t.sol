// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {RedeemInfo, RedeemInfoFrom} from "kimlikdao/IProtocolFund.sol";
import {uint48x2From} from "types/uint48x2.sol";

contract amountAddrTest is Test {
    function testAccessors() external pure {
        RedeemInfo info = RedeemInfoFrom(uint48x2From(2, 1), address(0x1337ACC));

        (uint256 total, uint256 amount, address addr) = info.unpack();
        assertEq(total, 2);
        assertEq(amount, 1);
        assertEq(addr, address(0x1337ACC));
    }
}
