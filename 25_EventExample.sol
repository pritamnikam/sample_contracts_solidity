pragma solidity ^0.8.0;

contract EventExample {
    
    event MyEvent(address _from, address _to, uint _amount);
    
    function sendMoney(address payable _to, uint _amount) public returns(bool) {
        emit MyEvent(msg.sender, _to, _amount);
        return true;
    }
}