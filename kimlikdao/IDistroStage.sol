// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

enum DistroStage {
    Presale1,
    Presale2,
    ProtocolSaleStart,
    ProtocolSaleEnd, // Unlocks Presale1
    ProtocolAMMStart,
    Presale2Unlock, // Unlocks Presale2
    FinalMint,
    FinalUnlock
}

interface IDistroStage {
    function distroStage() external view returns (DistroStage);
}
