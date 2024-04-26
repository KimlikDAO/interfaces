// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC165} from "./IERC165.sol";

interface IERC721Partial is IERC165 {
    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function balanceOf(address) external view returns (uint256);

    function tokenURI(uint256 tokenId) external view returns (string memory);

    function supportsInterface(bytes4 interfaceId) external pure returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
}

interface IERC721 is IERC721Partial {
    function ownerOf(uint256 tokenId) external view returns (address);
}
