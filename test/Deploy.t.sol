// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import { DeployChallenge } from "../src/Deploy.sol";

contract DeployTest is Test {
    DeployChallenge public deployChallenge;

    function setUp() public {
        deployChallenge = new DeployChallenge();
    }

    function testDeploy() public {
        assertTrue(deployChallenge.isComplete());
    }
}
