// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { CallMeChallenge } from "../src/CallMe.sol";

contract CallMeTest is Test {
    CallMeChallenge public callMeChallenge;

    function setUp() public {
        callMeChallenge = new CallMeChallenge();
    }

    function testCallMe() public {
        assertFalse(callMeChallenge.isComplete());

        callMeChallenge.callme();

        assertTrue(callMeChallenge.isComplete());
    }
}
