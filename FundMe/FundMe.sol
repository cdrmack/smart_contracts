// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PriceConverter} from "./PriceConverter.sol";

error FundMe__NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18; // 5 * 10 ** 18

    address[] public funders;
    mapping(address => uint256)  public fundersMap;
    address public immutable contractOwner;

    constructor() {
        contractOwner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.get_conversion_rate() >= MINIMUM_USD, "Didn't send enough ETH!");
        funders.push(msg.sender);
        fundersMap[msg.sender] += msg.value;
    }

    function number_of_founders() public view returns (uint256) {
        return funders.length;
    }

    modifier onlyOwner() {
        if (msg.sender != contractOwner) {
            revert FundMe__NotOwner();
        }
        _;
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            fundersMap[funder] = 0; // I think we should keep information who funded how much, even after withdraw
        }

        funders = new address[](0);

        // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Withdraw with `send` has failed");

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Withdraw with `call` has failed");
    }

    // https://solidity-by-example.org/fallback/
    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
