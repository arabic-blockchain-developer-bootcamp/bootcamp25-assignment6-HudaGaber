// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Assignment6 {
    event FundsDeposited(address indexed sender, uint amount);
    event FundsWithdrawn(address indexed receiver, uint amount);

    mapping(address => uint) public balances;

    modifier hasEnoughBalance(uint amount) {
        require(balances[msg.sender] >= amount, "not enough balance");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "must send ether");
        balances[msg.sender] += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    function withdraw(uint amount) external hasEnoughBalance(amount) {
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit FundsWithdrawn(msg.sender, amount);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
