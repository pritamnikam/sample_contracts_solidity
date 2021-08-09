pragma solidity ^0.8.4;

contract StartStopAndUpdateExample {
    
    address owner;
    bool public paused;
    
    constructor() {
        owner = msg.sender;
    }
    
    function sendMoney() public payable {
        
    }
    
    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not the owner.");
        paused = _paused;
    }
    
    function withdrawMoney(address payable _to) public {
        require(msg.sender == owner, "You are not the owner.");
        require(!paused, "Contract is paused.");
        _to.transfer(address(this).balance);
    }
    
    function destroyTheContract(address payable _to) public {
        require(msg.sender == owner, "You are not the owner.");
        selfdestruct(_to);
    }
}