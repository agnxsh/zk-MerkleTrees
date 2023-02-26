//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

interface IHasher {
    function MiMCSponge (
        uint256 inXL,
        uint256 inXR,
        uint256 k
     ) external pure returns (uint256 XL, uint256 XR);
}