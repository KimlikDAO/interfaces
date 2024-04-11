// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IL2Messenger {
    function sendL2ToL1Log(bool isService, bytes32 key, bytes32 value) external returns (uint256 logIdInMerkleTree);
}
