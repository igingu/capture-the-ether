// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { GuessTheSecretNumberChallenge } from "../src/GuessTheSecretNumber.sol";

contract GuessTheSecretNumberTest is Test {
    GuessTheSecretNumberChallenge public guessTheSecretNumberChallenge;

    bytes32 private constant answerHash = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;

    function setUp() public {
        guessTheSecretNumberChallenge = new GuessTheSecretNumberChallenge{value: 1 ether}();
    }

    function testGuessTheSecretNumber() public {
        assertFalse(guessTheSecretNumberChallenge.isComplete());

        for (uint8 answer; answer < type(uint8).max; ++answer) {
            if (keccak256(abi.encodePacked(answer)) == answerHash) {
                guessTheSecretNumberChallenge.guess{value: 1 ether}(answer);
                break;
            }
        }

        assertTrue(guessTheSecretNumberChallenge.isComplete());
    }

    receive() external payable {}
}
