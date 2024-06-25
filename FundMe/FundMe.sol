// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18; // 5 * 10 ** 18

    address[] public funders;
    mapping(address => uint256)  public fundersMap;

    function fund() public payable {
        require(msg.value.get_conversion_rate() >= MINIMUM_USD, "Didn't send enough ETH!");
        funders.push(msg.sender);
        fundersMap[msg.sender] += msg.value;
    }

    function number_of_founders() public view returns (uint256) {
        return funders.length;
    }
}
