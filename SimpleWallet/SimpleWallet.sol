//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

import "./Allowance.sol";

contract SimpleWallet is Allowance {
    
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyRecieved(address indexed _from, uint _amount);
    
    function viewBalance() public view returns(uint){
        return address(this).balance;
    }

    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "There is not enough funds in the smart contract");
        //if( !(owner() == _msgSender()) ){ // Owner is not losing allowance on withdraw
        reduceAllowance(_msgSender(), _amount);
        //}
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    
    function renounceOwnership() public view override onlyOwner {
        revert("Can't Renounce Ownership.");
    }

    fallback () external payable {
        emit MoneyRecieved(msg.sender, msg.value);
        addAllowance(msg.sender, msg.value);
    }
    receive() external payable {
        emit MoneyRecieved(msg.sender, msg.value);
        addAllowance(msg.sender, msg.value);
    }
}