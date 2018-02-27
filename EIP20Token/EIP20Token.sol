/*
Implements EIP20 token standard: https://github.com/ethereum/EIPs/issues/20
.*/
pragma solidity ^0.4.20;

import "./EIP20Interface.sol"; 

contract EIP20Token is EIP20Interface{

    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) public allowed;
       
    string public name;                             //fancy name: eg Alex Cabrera 
    string public symbol;                           //An identifier: eg ACG
     
    function EIP20Token() public {  
        name = "EIP20Token";                        // Set the name for display purposes
        decimals = 18;                              // Amount of decimals for display purposes
        symbol = "EIPT";                            // Set the symbol for display purposes
          
        totalSupply = 100000000 * 10 ** decimals;               // Update total supply
        balances[msg.sender] = totalSupply;         // Give the creator all initial tokens 
    } 
     
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
        Transfer(_from, _to, _value);
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }   
	 
}
