// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 minimumEth = 1;

    function fund() public payable {
        require(msg.value >= minimumEth, "didn't send enough ETH"); // 1e18 = 1 ETH
    }

    function get_version() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version(); // ETH/USD Price Feed, Sepolia Test Network
    }
}
