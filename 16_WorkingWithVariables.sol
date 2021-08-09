pragma solidity ^0.5.11;

contract WorkingWithVariables {
    uint256 public myUint;
    uint8 public myUint8;
    bool public myBool;
    address public myAddress;
    string public myString;
    
    function setMyUint(uint _myUnit) public {
        myUint = _myUnit;
    }
    
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    function incrementMyUint() public {
        myUint8++;
    }
    
    function decrementMyUint8() public {
        myUint8--;
    }
    
    function setAddress(address _address) public {
        myAddress = _address;
    }
    
    function getBalance() public view returns(uint) {
        return myAddress.balance;
    }
    
    function setMyString(string memory _myString) public {
        myString = _myString;
    }
}