// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./SimpleStorage.sol";

contract SimpleStorageFactory {
    SimpleStorage[] public simpleStorageContracts;

    function createSimpleStorageContract() public {
        SimpleStorage newContract = new SimpleStorage();
        simpleStorageContracts.push(newContract);
    }

    function store(uint256 _simpleStorageIndex, int32 _simpleStorageFavoriteNumber) public {
        simpleStorageContracts[_simpleStorageIndex].store(_simpleStorageFavoriteNumber);
    }

    function get(uint256 _simpleStorageIndex) public view returns (int32) {
        return simpleStorageContracts[_simpleStorageIndex].get();
    }
}
