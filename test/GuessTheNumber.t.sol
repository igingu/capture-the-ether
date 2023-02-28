// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { GuessTheNumberChallenge } from "../src/GuessTheNumber.sol";

contract GuessTheNumberTest is Test {
    GuessTheNumberChallenge public guessTheNumberChallenge;

    uint8 private constant answer = 42;

    function setUp() public {
        guessTheNumberChallenge = new GuessTheNumberChallenge{value: 1 ether}();
    }

    function testGuessTheNumber() public {
        assertFalse(guessTheNumberChallenge.isComplete());

        guessTheNumberChallenge.guess{value: 1 ether}(answer);

        assertTrue(guessTheNumberChallenge.isComplete());
    }

    receive() external payable {}
}
