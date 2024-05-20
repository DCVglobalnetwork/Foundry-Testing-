// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract Error {
    // Define a custom error
    error NotAuthorized();

    // Function that throws a generic error using require
    function throwError() external {
        require(false, "not authorized");
    }

    // Function that throws a custom error
    function throwCustomError() external {
        revert NotAuthorized();
    }
}
