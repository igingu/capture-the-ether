pragma solidity ^0.4.21;

interface IName {
    function name() external view returns (bytes32);
}

// @note - https://capturetheether.com/challenges/accounts/fuzzy-identity/
// @note - Solution:
//       - To pass isSmartx(msg.sender), msg.sender should be a smart contract with a function name() that returns bytes32("smarx")
//       - To pass isBadCode(msg.sender), msg.sender should be an address that contains "badc0de" anywhere inside the hex representation
//       - In order to achieve this, we can iterate through different salts of create2 to figure out which salt would create a correct address

contract FuzzyIdentityChallenge {
    bool public isComplete;

    function authenticate() public {
        require(isSmarx(msg.sender));
        require(isBadCode(msg.sender));

        isComplete = true;
    }

    function isSmarx(address addr) internal view returns (bool) {
        return IName(addr).name() == bytes32("smarx");
    }

    function isBadCode(address _addr) internal pure returns (bool) {
        bytes20 addr = bytes20(_addr);
        bytes20 id = hex"000000000000000000000000000000000badc0de";
        bytes20 mask = hex"000000000000000000000000000000000fffffff";

        for (uint256 i = 0; i < 34; i++) {
            if (addr & mask == id) {
                return true;
            }
            mask <<= 4;
            id <<= 4;
        }

        return false;
    }
}