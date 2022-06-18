pragma solidity ^0.5.0;

// This is the interface that must be implemented for an ERC-20 compliant token.
contract ERC20Interface {    
    // Returns the total supply of the token created.
    function totalSupply() public view returns (uint);

    // Returns the token balance for the supplied address.
    function balanceOf(address tokenOwner) public view returns (uint balance);

    // This function will cancel a transction if the user does not have sufficient balance.
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);

    // Allows the contract owner to give tokens to other users.
    function transfer(address to, uint tokens) public returns (bool success);

    // This function checks the transaction against the total supply of tokens to make sure that there are none missing or extra.
    function approve(address spender, uint tokens) public returns (bool success);

    // This function is used to support automated transfers to a specific account.
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    // Event raised on a transfer.
    event Transfer(address indexed from, address indexed to, uint tokens);

    // Event raised on an approval.
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
} // ERC20Interface



// Safe Math Library wrappers over Solidityâ€™s arithmetic operations with added overflow checks.
//   Arithmetic operations in Solidity wrap on overflow. This can easily result in bugs, because programmers usually assume that an 
//   overflow raises an error, which is the standard behavior in high level programming languages.
//   Safe Math restores this intuition by reverting the transaction when an operation overflows.
//   Using this library instead of the unchecked operations eliminates an entire class of bugs, so its use is recommended.
contract SafeMath {
    // The safe function for adding.
    function safeAdd(uint a, uint b) public pure returns (uint c) {
        c = a + b;
        require(c >= a);
    } // safeAdd

    // The safe function for subtraction.
    function safeSub(uint a, uint b) public pure returns (uint c) {
        require(b <= a); 
        c = a - b;
    } // safeSub

    // The safe function for multiplication.
    function safeMul(uint a, uint b) public pure returns (uint c) 
    { 
        c = a * b; 
        require(a == 0 || c / a == b); 
    } // safeMul

    // The safe function for division.
    function safeDiv(uint a, uint b) public pure returns (uint c) 
    { 
        require(b > 0);
        c = a / b;
    } // safeDiv
} // SafeMath


// Our new token Smart Contract.
// Our contract inherits from both the ERC20Interface contract 
//   as well as the SafeMath contract
contract MyToken is ERC20Interface, SafeMath {
    // Local Variables
    //   The token name
    string public name;
    
    //   The token symbol (3 characters)
    string public symbol;
    
    //   The token's precision (number of decimal places)
    uint8 public decimals;
    
    //   The total supply of the new token
    uint256 public _totalSupply;
    
    //   Mappings for account balances and allowed
    mapping(address => uint) balances;    
    mapping(address => mapping(address => uint)) allowed;

    // The constructor for our Smart Contract. 
    //   This function runs ONCE during deployment.
    constructor() public 
    {
        name = "MyToken";
        symbol = "MYT";
        decimals = 18;
        _totalSupply = 100000000000000000000000000;
        
        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    } // constructor

    // Returns the total supply of the token created.
    function totalSupply() public view returns (uint) 
    {
        return _totalSupply - balances[address(0)];
    } // totalSupply

    // Returns the token balance for the supplied address.
    function balanceOf(address tokenOwner) public view returns (uint balance) 
    {
        return balances[tokenOwner];
    } // balanceOf

    // This function will cancel a transction if the user does not have sufficient balance.
    function allowance (address tokenOwner, address spender) public view returns (uint remaining) 
    {
        return allowed[tokenOwner][spender];
    } // allowance

    // This function checks the transaction against the total supply of tokens to make sure that there are none missing or extra.
    function approve(address spender, uint tokens) public returns (bool success) 
    {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    } // approve

    // Allows the contract owner to give tokens to other users.
    function transfer(address to, uint tokens) public returns (bool success) 
    {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
    
        emit Transfer(msg.sender, to, tokens);
        return true;
    } // transfer
    
    // This function is used to support automated transfers to a specific account.
    function transferFrom (address from, address to, uint tokens) public returns (bool success) 
    {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
            
    	emit Transfer(from, to, tokens);
        return true;
    } // transferFrom

} // MyToken
