pragma solidity ^0.8.0;


import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
// import "https://github.com/ConsenSysMesh/openzeppelin-solidity/blob/master/contracts/math/SafeMath.sol";

// 1. define smart contract
// 2. secure the smart cotract
// 3. re-use open zepplin smart contract
// 4. Add allowance functinality
// 5. Add reduce-allowance functionality - double spend
// 6. Improve smart contract for better auditability
// 7. Add events for the Allowance Smart contract
// 8. Add events for the SharedWallet Smart contract
// 9. Add the SafeMath library
// 10. Remove RenounceOwnership functionality

contract Allowance  is Ownable {
    // using SafeMath for uint;
    
    event AllowanceChanges(address indexed _forWho,
                           address indexed _fromWhom,
                           uint _oldAmount,
                           uint _newAmount);
    
    mapping (address => uint) public allowance;
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        emit AllowanceChanges(_who,
                              msg.sender,
                              allowance[_who],
                              _amount);
        
        allowance[_who] = _amount;
    }
    
    function reduceAllowance(address _who, uint _amount) internal {
        emit AllowanceChanges(_who,
                              msg.sender,
                              allowance[_who],
                              allowance[_who] - _amount);
                              
        allowance[_who] = allowance[_who] - _amount;
    }
    
}

contract SharedWallet is Allowance {
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    
    function isOwner() public returns(bool) {
        return owner() == msg.sender;
    }
    
    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] > _amount, "You are not allowed.");
        _;
    }
    
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(allowance[_to] <= address(this).balance, "You don't have sufficient balance.");
        
        if (!isOwner()) {
            reduceAllowance(_to, _amount);
        }
        
        emit MoneySent(_to, _amount);
        
        _to.transfer(_amount);
    }
    
    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
    
    function renounceOwnership() public override onlyOwner {
        revert("can't renounceOwnership here"); //not possible with this smart contract
    }
}