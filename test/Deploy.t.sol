// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.3;
pragma experimental ABIEncoderV2;

import "forge-std/Test.sol";
import "../src/Deploy.sol";

contract DeployTest is Test {
    Deploy public deploy;

    function setUp() public {
        deploy = new Deploy();
    }

    function testDeployment() public {
        assertTrue(deploy.isComplete());
    }
}
