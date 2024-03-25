// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "contracts/Addresses.sol";
import "forge-std/Test.sol";
import {computeCreateAddress as computeEraVMCreateAddress} from "contracts/testing/eravm.sol";

contract AddressesTest is Test {
    function testDeployerConsistency() public pure {
        assertEq(computeCreateAddress(PROTOCOL_FUND_DEPLOYER, 0), PROTOCOL_FUND);
        assertEq(computeEraVMCreateAddress(ERAVM_PROTOCOL_FUND_DEPLOYER, 0), ERAVM_PROTOCOL_FUND);

        assertEq(computeCreateAddress(KDAO_DEPLOYER, 0), KDAO_ADDR);
        assertEq(computeEraVMCreateAddress(ERAVM_KDAO_DEPLOYER, 0), ERAVM_KDAO_ADDR);

        assertEq(computeCreateAddress(KDAO_DEPLOYER, 0), KDAO_ADDR);
        assertEq(computeEraVMCreateAddress(ERAVM_KDAO_DEPLOYER, 0), ERAVM_KDAO_ADDR);

        assertEq(computeCreateAddress(KDAOL_DEPLOYER, 0), KDAOL);
        assertEq(computeEraVMCreateAddress(ERAVM_KDAOL_DEPLOYER, 0), ERAVM_KDAOL);

        assertEq(computeCreateAddress(VOTING_DEPLOYER, 0), VOTING);
        assertEq(computeEraVMCreateAddress(ERAVM_VOTING_DEPLOYER, 0), ERAVM_VOTING);

        assertEq(computeCreateAddress(KPASS_SIGNERS_DEPLOYER, 0), KPASS_SIGNERS);
        assertEq(computeEraVMCreateAddress(ERAVM_KPASS_SIGNERS_DEPLOYER, 0), ERAVM_KPASS_SIGNERS);
    }
}
