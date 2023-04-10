pragma solidity ^0.4.21;

// @note - https://capturetheether.com/challenges/math/donation/
// @note - Solution: Creating and initializing "Donation" without specifying storage or memory
//       - leads to unexpected behavior
//       - It actually creates a pointer to storage, so assigning values in Donation will
//       - actually change the first two storage slots (uint256 - length of donations, and address - owner)
//       - Thus, we need to call donate with etherAmount = uint256 representation of our address
// @note - Doesn't work like this anymore, new compilers force you to specify data location
contract DonationChallenge {
    struct Donation {
        uint256 timestamp;
        uint256 etherAmount;
    }
    Donation[] public donations;

    address public owner;

    function DonationChallenge() public payable {
        require(msg.value == 1 ether);
        
        owner = msg.sender;
    }
    
    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function donate(uint256 etherAmount) public payable {
        // amount is in ether, but msg.value is in wei
        uint256 scale = 10**18 * 1 ether;
        require(msg.value == etherAmount / scale);

        Donation donation;
        donation.timestamp = now;
        donation.etherAmount = etherAmount;

        donations.push(donation);
    }

    function withdraw() public {
        require(msg.sender == owner);
        
        msg.sender.transfer(address(this).balance);
    }
}