pragma solidity ^0.4.0; 

contract Counter {
    uint value;
    
    constructor() public {
        value = 1000;
    }
    
    function initialize(uint _value) public {
        value = _value;
    }
    
    function increment(uint x) public {
        value += x;
    }
    
    function decrement(uint x) public {
        value -= x;
    }
    
    function get() public constant returns (uint) {
        return value;
    }
}