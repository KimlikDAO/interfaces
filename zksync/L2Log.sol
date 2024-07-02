// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

/**
 * @dev The log passed from L2
 * @param l2ShardId The shard identifier, 0 - rollup, 1 - porter. All other values are not used but are reserved for
 * the future
 * @param isService A boolean flag that is part of the log along with `key`, `value`, and `sender` address.
 * This field is required formally but does not have any special meaning.
 * @param txNumberInBatch The L2 transaction number in the batch, in which the log was sent
 * @param sender The L2 address which sent the log
 * @param key The 32 bytes of information that was sent in the log
 * @param value The 32 bytes of information that was sent in the log
 * Both `key` and `value` are arbitrary 32-bytes selected by the log sender
 */
struct L2Log {
    uint8 l2ShardId;
    bool isService;
    uint16 txNumberInBatch;
    address sender;
    bytes32 key;
    bytes32 value;
}

type L2LogLocator is uint256;

function L2LogLocatorFrom(uint256 _batchNumber, uint256 _messageIndex, uint256 _txNumber)
    pure
    returns (L2LogLocator)
{
    return L2LogLocator.wrap(_batchNumber << 128 | _messageIndex << 16 | _txNumber);
}

function batchNumber(L2LogLocator self) pure returns (uint256) {
    return L2LogLocator.unwrap(self) >> 128;
}

function messageIndex(L2LogLocator self) pure returns (uint256) {
    return uint112(L2LogLocator.unwrap(self) >> 16);
}

function txNumber(L2LogLocator self) pure returns (uint256) {
    return uint16(L2LogLocator.unwrap(self));
}

using {batchNumber, txNumber, messageIndex} for L2LogLocator global;
