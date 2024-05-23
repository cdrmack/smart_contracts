// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleStorage {
    int32 favoriteNumber;

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

    function store(int32 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function get() public view returns (int32) {
        return favoriteNumber;
    }
}
