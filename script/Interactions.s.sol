//SPDX-License-Identifier:MIT
//Fund
//Withdraw

pragma solidity ^0.8.18;
import {Script,console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";
contract FundFundMe is Script {
    uint256 constant SEND_VAL = 0.1 ether;
    function fundFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value:SEND_VAL}();
        vm.stopBroadcast();
        console.log("Funded FundMe with %s",SEND_VAL);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",block.chainid
        );
        fundFundMe(mostRecentlyDeployed);
    }

}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
        console.log("Withdrew Fund Balance");
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",block.chainid
        );
        withdrawFundMe(mostRecentlyDeployed);
    }

}