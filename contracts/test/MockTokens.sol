//SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

import "../IERC20Permit.sol";
import "forge-std/console2.sol";
import "forge-std/Vm.sol";

address constant USDT_DEPLOYER = 0x503560430E4b5814Dda09Ac789C3508Bb41b24B2;
address constant USDC_DEPLOYER = 0xcb9968Cb0d6612e1167e445774997C63a0792dbF;
address constant TRYB_DEPLOYER = 0xEE34DcaF2f48F3158Ef0BE8d0A2D37078cC9729b;

function DeployMockTokens() {
    Vm vm = Vm(
        address(bytes20(uint160(uint256(keccak256("hevm cheat code")))))
    );

    vm.setNonce(USDT_DEPLOYER, 2);
    vm.prank(USDT_DEPLOYER);
    IERC20Permit usdt = new MockERC20Permit("USDt", "TetherToken", 6);
    console2.log("USDT:", address(usdt));

    vm.setNonce(USDC_DEPLOYER, 4);
    vm.prank(USDC_DEPLOYER);
    IERC20Permit usdc = new MockERC20Permit("USDC", "USD Coin", 6);
    console2.log("USDC:", address(usdc));

    vm.setNonce(TRYB_DEPLOYER, 2);
    vm.prank(TRYB_DEPLOYER);
    IERC20Permit tryb = new MockERC20Permit("TRYB", "BiLira", 6);
    console2.log("TRYB:", address(tryb));
}

/**
 * @title Mock of the tokens we accepts as payment for testing purposes.
 */
contract MockERC20Permit is IERC20Permit {
    // keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
    bytes32 public constant PERMIT_TYPEHASH =
        0x6e71edae12b1b97f4d1f60370fef10105fa2faae0126114a169c64845d6126c9;
    bytes32 public immutable override DOMAIN_SEPARATOR;
    uint8 public immutable override decimals;

    string public override name;
    string public override symbol;
    uint256 public override totalSupply;
    mapping(address => uint256) public override balanceOf;
    mapping(address => mapping(address => uint256)) public override allowance;
    mapping(address => uint256) public override nonces;

    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        uint8 tokenDecimals
    ) {
        name = tokenName;
        symbol = tokenSymbol;
        decimals = tokenDecimals;
        uint256 toMint = 100 * 10**decimals;
        balanceOf[msg.sender] += toMint;
        totalSupply += toMint;

        emit Transfer(address(this), msg.sender, toMint);
        DOMAIN_SEPARATOR = keccak256(
            abi.encode(
                keccak256(
                    "EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"
                ),
                keccak256(bytes(symbol)),
                keccak256(bytes("1")),
                block.chainid,
                address(this)
            )
        );
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        balanceOf[msg.sender] -= amount;
        unchecked {
            balanceOf[to] += amount;
        }
        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external override returns (bool) {
        uint256 allowed = allowance[from][msg.sender];
        if (allowed != type(uint256).max)
            allowance[from][msg.sender] = allowed - amount;
        balanceOf[from] -= amount;
        unchecked {
            balanceOf[to] += amount;
        }
        emit Transfer(from, to, amount);
        return true;
    }

    function permit(
        address owner,
        address spender,
        uint256 amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        require(deadline >= block.timestamp);
        unchecked {
            bytes32 digest = keccak256(
                abi.encodePacked(
                    "\x19\x01",
                    DOMAIN_SEPARATOR,
                    keccak256(
                        abi.encode(
                            PERMIT_TYPEHASH,
                            owner,
                            spender,
                            amount,
                            nonces[owner]++,
                            deadline
                        )
                    )
                )
            );
            address recovered = ecrecover(digest, v, r, s);
            require(recovered != address(0) && recovered == owner);
        }
        allowance[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
}
