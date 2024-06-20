// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public constant MINIMUM_USD = 5e18; // 5 * 10 ** 18

    address[] public funders;
    mapping(address => uint256)  public fundersMap;

    function fund() public payable {
        require(get_conversion_rate(msg.value) >= MINIMUM_USD, "Didn't send enough ETH!");
        funders.push(msg.sender);
        fundersMap[msg.sender] += msg.value;
    }

    function number_of_founders() public view returns (uint256) {
        return funders.length;
    }

    /*
    * USD/ETH - 18 decimals
    * ETH/USD - 8 decimals
    * can be checked with .decimals() on contract itself
    */
    function get_price() public view returns (uint256) {
        // Sepolia ETH/USD Address
        // https://docs.chain.link/data-feeds/price-feeds/addresses
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        // https://docs.chain.link/data-feeds/api-reference#getrounddata
        (, int256 answer,,,) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }

    function get_conversion_rate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = get_price();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
