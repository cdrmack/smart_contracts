// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Counter {
	int32 number = 0;

	function get() public view returns (int32) {
		return number;
	}

	function inc() public {
		number += 1;
	}

	function dec() public {
		number -= 1;
	}
}
