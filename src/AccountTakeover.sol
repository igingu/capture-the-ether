// @note - https://capturetheether.com/challenges/accounts/account-takeover/
// @note - Read solution from: https://cmichel.io/capture-the-ether-solutions/

pragma solidity ^0.4.21;

contract AccountTakeoverChallenge {
    address owner = 0x6B477781b0e68031109f21887e6B5afEAaEB002b;
    bool public isComplete;

    function authenticate() public {
        require(msg.sender == owner);

        isComplete = true;
    }
}