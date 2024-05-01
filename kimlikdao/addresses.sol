// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

//
// The protocol funds on Ethereum L2s forward the funds to Ethereum
// periodically. The redemption happens on Ethereum mainnet using the `redeem()`
// method of KDAO on Ethereum.
//
// The protocol funds on alt L1s stay on its native chain and redeemed in-kind
// on the corresponding chain. The redemption signal is forwarded to the chain
// by the KimlikDAO signer nodes using BLS signatures.
//
// kimlikdao.eth
address payable constant PROTOCOL_FUND = payable(0xcCc0106Dbc0291A0d5C97AAb42052Cb46dE60cCc);
address constant PROTOCOL_FUND_DEPLOYER = 0x0DabB96F2320A170ac0dDc985d105913D937ea9A;

//
// zksync.kimlikdao.eth
//
address payable constant PROTOCOL_FUND_ZKSYNC = payable(0xcCc0f14de126FD0D2707Ad39F1b7698921550cCc);
address constant PROTOCOL_FUND_ZKSYNC_DEPLOYER = 0xadBde24bfC12829b30FaEe9cF5daB0F91AdC9400;

// KPASS addresses
address constant KPASS = 0xcCc0a9b023177549fcf26c947edb5bfD9B230cCc;
address constant KPASS_DEPLOYER = 0x305166299B002a9aDE0e907dEd848878FD2237D7;
address constant KPASS_ZKSYNC = 0xcCc053d81e3B85Eac133a5333be4D7cBDd120cCc;
address constant KPASS_ZKSYNC_DEPLOYER = 0x1F7766565AaDD753379181678623273A82f8603c;

// KDAO addresses
address constant KDAO_ETHEREUM = 0xcCc0AC04C9251B74b0b30A20Fc7cb26EB62B0cCc;
address constant KDAO_ETHEREUM_DEPLOYER = 0xe7671eb60A45c905387df2b19A3803c6Be0Eb8f9;
address constant KDAO_ZKSYNC = 0xcCc0b95cE2e18223bA8059F2c9Fad9d914450cCc;
address constant KDAO_ZKSYNC_DEPLOYER = 0x0410641e73f261b98EB7aB189F6b4e1052833c2A;
address constant KDAO_ZKSYNC_ALIAS = 0xdDd1AC04c9251B74B0B30A20FC7cb26Eb62b1ddd;
address constant KDAO_PRESALE = 0xcCc07b3e77516A13B6810112E8fA6D2895c31cCc;
address constant KDAO_PRESALE_DEPLOYER = 0x006d0847bad678B2b5116E74C69Da301d7172cfA;

// KDAO-l addresses
address constant KDAO_LOCKED = 0xcCc0948D9e47Ab3932271DA380B3525DD05a1cCc;
address constant KDAO_LOCKED_DEPLOYER = 0xb81bFa6348ACc1Dab88cc2b35d7eEce4A68aE2b2;

//
// Voting contract
//
address constant VOTING_EVM = 0xcCc01Ec0E6Fb38Cce8b313c3c8dbfe66efD01cCc;
address constant VOTING_EVM_DEPLOYER = 0xD808C187Ef7D6f9999b6D9538C72E095db8c6df9;
address constant VOTING = 0xcCc0a523f5392AD629EfAA49E71844E61AB81cCc;
address constant VOTING_DEPLOYER = 0x526F38A49130169412B00De254bDafbaAB4E7E91;

// KPASS Signers
address constant KPASS_SIGNERS_EVM = 0xcCc09aA0d174271259D093C598FCe9Feb2791cCc;
address constant KPASS_SIGNERS_EVM_DEPLOYER = 0x4DeA92Bcb2C22011217C089797A270DfA5A51d53;
address constant KPASS_SIGNERS = 0xcCc0b54E5538fa5B4E0EcE1f2B0ba9C01c8A1cCc;
address constant KPASS_SIGNERS_DEPLOYER = 0x755DDeBf547DD2e9838d16b51525fe8e925a56D0;

// dev.kimlikdao.eth
address constant DEV_FUND = 0xC152e02e54CbeaCB51785C174994c2084bd9EF51;
