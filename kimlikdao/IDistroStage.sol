// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

enum DistroStage {
    Presale1,
    Presale2,
    ProtocolSaleStart,
    ProtocolSaleEnd,
    ProtocolAMMStart,
    Presale2Unlock,
    FinalMint,
    FinalUnlock
}

interface IDistroStage {
    function distroStage() external view returns (DistroStage);
}
