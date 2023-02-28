// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { AssumeOwnershipChallenge } from "../src/AssumeOwnership.sol";

contract AssumeOwnershipTest is Test {
    AssumeOwnershipChallenge public assumeOwnershipChallenge;

    function setUp() public {
        assumeOwnershipChallenge = new AssumeOwnershipChallenge();
    }

    function testAssumeOwnership() public {
        assertFalse(assumeOwnershipChallenge.isComplete());

        assumeOwnershipChallenge.AssumeOwmershipChallenge();
        assumeOwnershipChallenge.authenticate();

        assertTrue(assumeOwnershipChallenge.isComplete());
    }
}
