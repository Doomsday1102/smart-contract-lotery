// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {Raffle} from "src/Raffle.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {CreateSubscription,FundSubscription,AddConsumer} from "script/Interaction.s.sol";

contract DeployRaffle is Script {

    function run() public {
        deployContract();
    }

    function deployContract() public returns(Raffle , HelperConfig) {
        HelperConfig helperConfig = new HelperConfig();
        //local -> deploy mocks, get local configs
        //sepolia -> get sepolia configs
        HelperConfig.NetworkConfig memory config = helperConfig.getConfig();

        if(config.subscriptionId == 0){
            CreateSubscription createSubscription = new CreateSubscription();
            (config.subscriptionId,config.vrfCoordinator)=createSubscription.createSubscription(config.vrfCoordinator);

            //Fund it
            FundSubscription fundSubscription = new FundSubscription();
            fundSubscription.fundSubscription(config.vrfCoordinator,config.subscriptionId,config.link);
        }

        vm.startBroadcast();
        Raffle raffle = new Raffle(
            config.entranceFee,
            config.interval,
            config.vrfCoordinator,
            config.gasLane,
            config.subscriptionId,
            config.callbackGasLimit
        );
        vm.stopBroadcast();

        AddConsumer addConsumer = new AddConsumer();
        // don't need broadcast because already are in AddConsumer
        addConsumer.addConsumer(address(raffle),config.vrfCoordinator,config.subscriptionId);

        return (raffle, helperConfig);

    }

}

