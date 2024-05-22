// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleStorage {
    struct Person {
        string name;
        int32 favoriteNumber;
    }

    Person[] public people;
    mapping(string => int32) public nameToFavoriteNumber;

    function addPerson(string memory _name, int32 _favoriteNumber) public {
        people.push(Person(_name, _favoriteNumber));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}
