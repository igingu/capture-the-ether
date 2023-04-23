// @note - https://capturetheether.com/challenges/accounts/public-key/
// @note - Read solution from https://capturetheether.com/challenges/accounts/public-key/
pragma solidity ^0.4.21;

contract PublicKeyChallenge {
    address owner = 0x92b28647ae1f3264661f72fb2eb9625a89d88a31;
    bool public isComplete;

    function authenticate(bytes publicKey) public {
        require(address(keccak256(publicKey)) == owner);

        isComplete = true;
    }
}