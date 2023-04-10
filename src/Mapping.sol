pragma solidity ^0.4.21;

// @note - https://capturetheether.com/challenges/math/mapping/
// @note - Solution:
//       - Do the same as for https://github.com/igingu/ethernaut/tree/main/19%20-%20Alien%20Codex
contract MappingChallenge {
    bool public isComplete;
    uint256[] map;

    function set(uint256 key, uint256 value) public {
        // Expand dynamic array as needed
        if (map.length <= key) {
            map.length = key + 1;
        }

        map[key] = value;
    }

    function get(uint256 key) public view returns (uint256) {
        return map[key];
    }
}