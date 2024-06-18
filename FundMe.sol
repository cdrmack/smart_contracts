// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundMe {
    uint256 minimumEth = 1;

    function fund() public payable {
        require(msg.value >= minimumEth, "didn't send enough ETH"); // 1e18 = 1 ETH
    }
}
