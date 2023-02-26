//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "contracts/interfaces/IHasher.sol";
import "hardhat/console.sol";


contract BuildMerkleTree {
    uint256 public constant FIELDSIZE = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    uint256 public constant ZEROVALUE = 21663839004416932945382355908790599225266501822907911457504978515578255421292;

    IHasher public immutable hasher;

    uint256 public levels;

    /**
     * @notice These variables are for now made public for easier testing and debugging and 
     * are supposed to be accessible in production-level code.
     */

    /** 
     * filledSubtrees and roots could have been bytes32[arrSize], but using mappings makes it alot cheaper
     * it removes the index range while searching, and reduces time-complexity from O(N) => O(log N)
    */
   
    mapping (uint256 => bytes32) public filledSubtrees;
    mapping (uint256 => bytes32) public roots;
    
    uint32 public constant ROOTPREVSIZE = 30;
    uint32 public constant currRootIndex = 0;
    uint32 public constant nextIndex = 0;

    constructor(uint32 _levels, IHasher _hasher) {

        require(_levels > 0, "_levels should be greater than zero");
        require(_levels < 32, "_levels should be less than 32");
        levels = _levels;
        hasher = _hasher;
    }
}