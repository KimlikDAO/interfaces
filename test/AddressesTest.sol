// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "contracts/Addresses.sol";
import "forge-std/Test.sol";

contract Dummy {}

contract AddressesTest is Test {
    function testDeployerConsistency() public {
        // DAO_KASASI
        vm.prank(DAO_KASASI_DEPLOYER);
        Dummy daoKasasi = new Dummy();

        assertEq(address(daoKasasi), DAO_KASASI);

        // OYLAMA
        vm.prank(OYLAMA_DEPLOYER);
        Dummy oylama = new Dummy();

        assertEq(address(oylama), OYLAMA);

        // TCKO
        vm.prank(TCKO_DEPLOYER);
        Dummy tcko = new Dummy();

        assertEq(address(tcko), TCKO_ADDR);

        vm.prank(TCKOK_DEPLOYER);
        Dummy tckok = new Dummy();

        assertEq(address(tckok), TCKOK);

        // TCKT
        vm.prank(TCKT_DEPLOYER);
        Dummy tckt = new Dummy();
        vm.prank(TCKT_SIGNERS_DEPLOYER);
        Dummy tcktSigners = new Dummy();

        assertEq(address(tckt), TCKT_ADDR);
        assertEq(address(tcktSigners), TCKT_SIGNERS);
    }
}
