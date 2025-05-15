// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Assignment6.sol";

contract Assignment6Test is Test {
    Assignment6 assignment;

    function setUp() public {
        assignment = new Assignment6();
    }

    function testDeposit() public {
        vm.deal(address(this), 1 ether);
        vm.expectEmit(true, true, false, true);
        emit Assignment6.FundsDeposited(address(this), 1 ether);
        assignment.deposit{value: 1 ether}();
        uint balance = assignment.balances(address(this));
        assertEq(balance, 1 ether, "Balance should be 1 ether");
    }

    function testWithdraw() public {
        vm.deal(address(this), 1 ether);
        assignment.deposit{value: 1 ether}();
        vm.expectEmit(true, true, false, true);
        emit Assignment6.FundsWithdrawn(address(this), 0.5 ether);
        assignment.withdraw(0.5 ether);
        uint balance = assignment.balances(address(this));
        assertEq(balance, 0.5 ether, "Balance should be 0.5 ether");
    }

    function testContractBalance() public {
        vm.deal(address(this), 1 ether);
        assignment.deposit{value: 1 ether}();
        uint contractBalance = assignment.getContractBalance();
        assertEq(contractBalance, 1 ether, "Contract balance should be 1 ether");
    }

    receive() external payable {}
}
