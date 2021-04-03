//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.1;

contract Ownable{
    address payable _owner;
    
    constructor() {
        _owner = payable(msg.sender);
    }
    
    modifier onlyOwner() {
        require(isOwner(), "You are not owner");
        _;
    }
    
    function isOwner() public view returns(bool){
        return(msg.sender == _owner);
    }
}