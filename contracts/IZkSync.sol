// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

enum TxStatus {
    Failure,
    Success
}

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

uint160 constant ALIAS_OFFSET = uint160(0x1111000000000000000000000000000000001111);

/**
 * @notice Utility function converts the address that submitted a tx
 * to the inbox on L1 to the msg.sender viewed on L2
 * @param l1Address the address in the L1 that triggered the tx to L2
 * @return l2Address L2 address as viewed in msg.sender
 */
function applyL1ToL2Alias(address l1Address) pure returns (address l2Address) {
    unchecked {
        l2Address = address(uint160(l1Address) + ALIAS_OFFSET);
    }
}

/**
 * @notice Utility function that converts the msg.sender viewed on L2 to the
 * address that submitted a tx to the inbox on L1
 * @param l2Address L2 address as viewed in msg.sender
 * @return l1Address the address in the L1 that triggered the tx to L2
 */
function undoL1ToL2Alias(address l2Address) pure returns (address l1Address) {
    unchecked {
        l1Address = address(uint160(l2Address) - ALIAS_OFFSET);
    }
}

bytes32 constant CREATE_PREFIX = 0x63bae3a9951d38e8a3fbb7b70909afc1200610fc5bc55ade242f815974674f23;

function computeCreateAddress(address deployer, uint256 nonce) pure returns (address) {
    bytes32 hash = keccak256(bytes.concat(CREATE_PREFIX, bytes32(uint256(uint160(deployer))), bytes32(nonce)));
    return address(uint160(uint256(hash)));
}

interface IZkSync {
    /**
     * @notice Request execution of L2 transaction from L1.
     * @param contractL2 The L2 receiver address
     * @param l2Value `msg.value` of L2 transaction
     * @param calldataBytes The input of the L2 transaction
     * @param l2GasLimit Maximum amount of L2 gas that transaction can consume during execution on L2
     * @param l2GasPerPubdataByteLimit The maximum amount L2 gas that the operator may charge the user for single byte of pubdata.
     * @param factoryDeps An array of L2 bytecodes that will be marked as known on L2
     * @param refundRecipient The address on L2 that will receive the refund for the transaction.
     * @dev If the L2 deposit finalization transaction fails, the `_refundRecipient` will receive the `_l2Value`.
     * Please note, the contract may change the refund recipient's address to eliminate sending funds to addresses out of control.
     * - If `_refundRecipient` is a contract on L1, the refund will be sent to the aliased `_refundRecipient`.
     * - If `_refundRecipient` is set to `address(0)` and the sender has NO deployed bytecode on L1, the refund will be sent to the `msg.sender` address.
     * - If `_refundRecipient` is set to `address(0)` and the sender has deployed bytecode on L1, the refund will be sent to the aliased `msg.sender` address.
     * @dev The address aliasing of L1 contracts as refund recipient on L2 is necessary to guarantee that the funds are controllable,
     * since address aliasing to the from address for the L2 tx will be applied if the L1 `msg.sender` is a contract.
     * Without address aliasing for L1 contracts as refund recipients they would not be able to make proper L2 tx requests
     * through the Mailbox to use or withdraw the funds from L2, and the funds would be lost.
     * @return canonicalTxHash The hash of the requested L2 transaction. This hash can be used to follow the transaction status
     */
    function requestL2Transaction(
        address contractL2,
        uint256 l2Value,
        bytes calldata calldataBytes,
        uint256 l2GasLimit,
        uint256 l2GasPerPubdataByteLimit,
        bytes[] calldata factoryDeps,
        address refundRecipient
    ) external payable returns (bytes32 canonicalTxHash);

    /**
     * @notice Prove that the L1 -> L2 transaction was processed with the specified status.
     * @param l2TxHash The L2 canonical transaction hash
     * @param l2BatchNumber The L2 batch number where the transaction was processed
     * @param l2MessageIndex The position in the L2 logs Merkle tree of the l2Log that was sent with the message
     * @param l2TxNumberInBatch The L2 transaction number in the batch, in which the log was sent
     * @param merkleProof The Merkle proof of the processing L1 -> L2 transaction
     * @param status The execution status of the L1 -> L2 transaction (true - success & 0 - fail)
     * @return Whether the proof is correct and the transaction was actually executed with provided status
     */
    function proveL1ToL2TransactionStatus(
        bytes32 l2TxHash,
        uint256 l2BatchNumber,
        uint256 l2MessageIndex,
        uint16 l2TxNumberInBatch,
        bytes32[] calldata merkleProof,
        TxStatus status
    ) external view returns (bool);

    /**
     * @notice Prove that a specific L2 log was sent in a specific L2 batch
     * @param l2BatchNumber The executed L2 batch number in which the log appeared
     * @param l2LogIndex The position of the l2log in the L2 logs Merkle tree
     * @param l2Log Information about the sent log
     * @param merkleProof Merkle proof for inclusion of the L2 log
     * @return Whether the proof is correct and L2 log is included in batch
     */
    function proveL2LogInclusion(
        uint256 l2BatchNumber,
        uint256 l2LogIndex,
        L2Log memory l2Log,
        bytes32[] calldata merkleProof
    ) external view returns (bool);
}

IZkSync constant ZkSync = IZkSync(0xaBEA9132b05A70803a4E85094fD0e1800777fBEF);

interface IL2Messenger {
    function sendL2ToL1Log(bool isService, bytes32 key, bytes32 value) external returns (uint256 logIdInMerkleTree);
}
