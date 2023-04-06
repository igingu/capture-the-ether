pragma solidity ^0.4.21;

// @note - https://capturetheether.com/challenges/math/token-sale/

// @note - Solution:
//       - This uses an old Solidity version, so overflow is possible
//       - Call buy function with numTokens so that multiplication overflows
//       - msg.value should be the first overflow over type(uint256).max of the multiplication
//       - Contract will have a balance of X < 2 ether now
//       - msg.sender will have a big, and it can call sell(1)
//       - Contract will have a balance of X < 1 ether now

contract TokenSaleChallenge {
    mapping(address => uint256) public balanceOf;
    uint256 constant PRICE_PER_TOKEN = 1 ether;

    function TokenSaleChallenge(address _player) public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance < 1 ether;
    }

    function buy(uint256 numTokens) public payable {
        require(msg.value == numTokens * PRICE_PER_TOKEN);

        balanceOf[msg.sender] += numTokens;
    }

    function sell(uint256 numTokens) public {
        require(balanceOf[msg.sender] >= numTokens);

        balanceOf[msg.sender] -= numTokens;
        msg.sender.transfer(numTokens * PRICE_PER_TOKEN);
    }
}