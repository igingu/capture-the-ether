pragma solidity ^0.4.21;

// @note - https://capturetheether.com/challenges/lotteries/predict-the-block-hash/
//       - Guessing an 8-bit number is apparently too easy. 
//       - This time, you need to predict the entire 256-bit block hash for a future block.
// @note - Solution:
//       - Information on block.blockhash: https://docs.soliditylang.org/en/v0.4.24/units-and-global-variables.html#block-and-transaction-properties
//       - blockhash returns bytes32(0) for blockNumber >= block.number and blockNumber < block.number - 256
//       - Create a smart contract with function:
// ```
// function lockInGuess() external payable {
//     predictTheBlockChallenge.lockInGuess{value: 1 ether}(bytes32(0))
// }
// ```
//       - Wait 256 blocks, so block.blockhash(settlementBlockNumber) will return bytes32(0)
//       - Call settle()
contract PredictTheBlockHashChallenge {
    address guesser;
    bytes32 guess;
    uint256 settlementBlockNumber;

    function PredictTheBlockHashChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(bytes32 hash) public payable {
        require(guesser == 0);
        require(msg.value == 1 ether);

        guesser = msg.sender;
        guess = hash;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        bytes32 answer = block.blockhash(settlementBlockNumber);

        guesser = 0;
        if (guess == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}