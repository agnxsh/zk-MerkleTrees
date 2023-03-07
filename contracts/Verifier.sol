//SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

library Pairing {
   struct G1Point{
    uint X;
    uint Y;
   } 

   //Encoding of the field elements are : X[0]*z + X[1]
   struct G2Point{
    uint[2] X;
    uint[2] Y;
   }

   //@returns the generator of G1 with the initial point in (1,2)
   function P1() internal pure returns (G1Point memory){
    return G1Point(1,2);
   }

   //@returns the generator of G2 with the initial point that exists as a subgroup
   function P2() internal pure returns (G2Point memory){
    return G2Point
    ( [11559732032986387107991004021392285783925812861821192530917403151452391805634,
    10857046999023057135944570762232829481370756359578518086990519993285655852781],
    [4082367875863433681332203403145435568316851327593401208105741076214120093531,
    8495653923123431417604973247489272438418190587263600148770280649306958101930]);
   }


    ///@return r the negation of p, that is, p.addition(p.negate()) == 0
    function negate(G1Point memory p) internal view returns (G1Point memory r){
        //the q variable represent the prime number which in turn represents the prime field F_q for the generator G1
        uint q = 21888242871839275222246405745257275088696311157297823662689037894645226208583;
        if(p.X ==0 && p.Y ==0){
            return G1Point(0,0);
        }
        return G1Point(p.X, q-(p.Y % q));
    }

    ///@return r the sum of two points of G1
    function addition (G1Point memory p1, G1Point memory p2) internal view returns(G1Point memory r){
        uint[4] memory input;
        input[0] = p1.X;
        input[1] = p1.Y;
        input[2] = p2.X;
        input[3] = p2.Y;

        bool success;
        //solium-disable-next-line security/no-inline-assembly
        assembly{
            success := staticcall(sub(gas(), 2000),6,input,0xc0,r,0x60)
            //use "invalid" to make gas estimation work
            switch success case 0 {invalid()}
        }
    }
}