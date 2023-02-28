pragma solidity ^0.6.3;

// To fix https://github.com/foundry-rs/foundry/issues/4376
pragma experimental ABIEncoderV2;

contract GuessTheNewNumberChallenge {
    constructor() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);
        uint8 answer = uint8(uint(keccak256(abi.encodePacked(blockhash(block.number - 1), now))));

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}