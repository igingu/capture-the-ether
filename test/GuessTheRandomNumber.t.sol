// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { GuessTheRandomNumberChallenge } from "../src/GuessTheRandomNumber.sol";

contract GuessTheRandomNumberTest is Test {
    GuessTheRandomNumberChallenge public guessTheRandomNumberChallenge;

    uint8 answer;   

    function setUp() public {
        guessTheRandomNumberChallenge = new GuessTheRandomNumberChallenge{value: 1 ether}();

        answer = uint8(uint(keccak256(abi.encodePacked(blockhash(block.number - 1), now))));
    }

    function testGuessTheRandomNumber() public {
        assertFalse(guessTheRandomNumberChallenge.isComplete());

        guessTheRandomNumberChallenge.guess{value: 1 ether}(answer);

        assertTrue(guessTheRandomNumberChallenge.isComplete());
    }

    receive() external payable {}
}
