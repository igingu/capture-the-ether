// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { GuessTheNewNumberChallenge } from "../src/GuessTheNewNumber.sol";

contract GuessTheNewNumberTest is Test {
    GuessTheNewNumberChallenge public guessTheNewNumberChallenge;

    function setUp() public {
        guessTheNewNumberChallenge = new GuessTheNewNumberChallenge{value: 1 ether}();
    }

    function testGuessTheNewNumber() public {
        assertFalse(guessTheNewNumberChallenge.isComplete());

        uint8 answer = uint8(uint(keccak256(abi.encodePacked(blockhash(block.number - 1), now))));
        guessTheNewNumberChallenge.guess{value: 1 ether}(answer);

        assertTrue(guessTheNewNumberChallenge.isComplete());
    }

    receive() external payable {}
}
