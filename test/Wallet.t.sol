// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet} from "../src/Wallet.sol";

// Examples of deal and hoax
// deal(address, uint) - Set balance of address
// hoax(address, uint) - deal + prank, Sets up a prank and set balance

contract WalletTest is Test {
    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet{value: 1e18}();
    }

    function _send(uint256 amount) private {
        (bool ok, ) = address(wallet).call{value: amount}("");
        require(ok, "send ETH failed");
    }

    function testEthBalance() public {
        console.log("ETH balance", address(this).balance / 1e18);
    }

    function testSendEth() public {
        // lets set up the balance before we check for the balance
        uint balance = address(wallet).balance;
        // deal(address, uint) - Set balance of address
        deal(address(1), 100);
        assertEq(address(1).balance, 100);
        //  deal(address(1), 10);
        // assertEq(address(1).balance, 10);

        // hoax(address, uint) - deal + prank, Sets up a prank and set balance
        deal(address(1), 234); // we set the address of Eth
        vm.prank(address(1)); //
        _send(234);

        // doing the same thing using hoax
        hoax(address(1), 998);
        _send(998);

        // after we executed all these codes above we will check the balance
        assertEq(address(wallet).balance, balance + 234 + 998);
    }
}
