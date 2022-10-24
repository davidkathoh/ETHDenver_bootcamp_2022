// SPDX-License-Identifier: UNLICENSED

pragma solidity  ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract VolcanoCoin is Ownable{

    uint  public totalSupply = 10000;
    mapping(address => uint) public balances;

    constructor(){
        balances[msg.sender] = totalSupply;
    }

    struct Payment{
        uint amount;
        address recipient;
    }

    mapping(address => Payment[]) payments;

    event SupplyChange(uint _totalSupply);
    event Transfer(uint _amount,address _to);
   

    function increaseSupply() public onlyOwner{
        totalSupply +=totalSupply;
        emit SupplyChange(totalSupply);
    }

    function transfer(uint _amount, address _to)public{
        uint  balance = balances[msg.sender];
        require(_amount <= balance,"Unsufficient balance ");
        require(_to != address(0)," Can't send to a zero address");

        balances[_to] = _amount;
        balances[msg.sender] = balance - _amount;

        payments[msg.sender].push(Payment({amount: _amount,recipient:_to}));
        emit Transfer(_amount,_to);

    }

    
}

