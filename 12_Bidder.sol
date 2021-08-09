pragma solidity ^0.4.0; 

contract Bidder {
    
     string public name = "Hello";
     uint public bidAmount;
     bool public eligible;
     uint constant minBid = 1000;
     
     function setName(string str) public {
         name = str;
     }
     
     function setBidAmount(uint x) public {
         bidAmount = x;
     }
     
     function determineEligibility() public {
         if (bidAmount >= minBid) {
             eligible = true;
         }  else {
             eligible = false;
         }
     }
}