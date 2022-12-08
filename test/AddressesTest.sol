// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "contracts/Addresses.sol";
import "contracts/IDAOKasasi.sol";
import "contracts/testing/MockDAOKasasi.sol";
import "forge-std/Test.sol";

contract Dummy {}

contract AddressesTest is Test {
    function testDeployerConsistency() public {
        // DAO_KASASI
        vm.prank(DAO_KASASI_DEPLOYER);
        IDAOKasasi daoKasasi = new MockDAOKasasi();

        assertEq(address(daoKasasi), DAO_KASASI);

        // OYLAMA
        vm.prank(OYLAMA_DEPLOYER);
        Dummy oylama = new Dummy();

        assertEq(address(oylama), OYLAMA);

        // TCKO
        vm.startPrank(TCKO_DEPLOYER);
        Dummy tcko = new Dummy();
        Dummy tckok = new Dummy();
        vm.stopPrank();

        assertEq(address(tcko), TCKO_ADDR);
        assertEq(address(tckok), TCKOK);

        // TCKT
        vm.prank(TCKT_DEPLOYER);
        Dummy tckt = new Dummy();

        assertEq(address(tckt), TCKT_ADDR);
    }
}
