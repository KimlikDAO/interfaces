// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IL1Messenger {
    function sendToL1(bytes memory _message) external returns (bytes32);
}

address constant L1_MESSENGER = 0x0000000000000000000000000000000000008008;

IL1Messenger constant L1Messenger = IL1Messenger(L1_MESSENGER);
