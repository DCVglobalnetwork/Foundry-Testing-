// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {Error} from "../src/Error.sol";

contract ErrorTest is Test {
    Error public error;

    function setUp() public {
        error = new Error();
    }

    function testFail() public {
        error.throwError();
    }

    function testRevert() public {
        vm.expectRevert();
        error.throwError();
    }

    function testRequireMessage() public {
        vm.expectRevert(bytes("not authorized"));
        error.throwError();
    }

    function testCustomError() public {
        vm.expectRevert(Error.NotAuthorized.selector);
        error.throwCustomError();
    }

    function testErrorLabel() public {
        assertEq(uint256(1), uint256(1), "test 1");
        assertEq(uint256(1), uint256(1), "test 2");
        assertEq(uint256(1), uint256(1), "test 3");
        assertEq(uint256(1), uint256(1), "test 4");
        assertEq(uint256(1), uint256(1), "test 5");
    }
}
