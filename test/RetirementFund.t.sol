// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { RetirementFundChallenge, RetirementFundChallengeHack } from "../src/RetirementFund.sol";

contract RetirementFundTest is Test {
    RetirementFundChallenge public retirementFundChallenge;
    RetirementFundChallengeHack public retirementFundChallengeHack;

    function setUp() public {
        retirementFundChallenge = new RetirementFundChallenge{value: 1 ether}(address(this));
        retirementFundChallengeHack = new RetirementFundChallengeHack{value: 1 ether}();
    }

    function testRetirementFund() public {
        assertFalse(retirementFundChallenge.isComplete());

        retirementFundChallengeHack.destructContract(payable((address(retirementFundChallenge))));
        retirementFundChallenge.collectPenalty();

        assertTrue(retirementFundChallenge.isComplete());
    }

    receive() external payable {}
}
