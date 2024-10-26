// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

/**
 * @title A sample Raffle contract
 * @author Diego A. Orrego Torrejon
 * @notice This contract is for createing a sample raffle
 * @dev Implements Chainlink VRFv2.5
 */

contract Raffle {
    /**     Errors */
    error Raffle__SendMoreEnterRaffle();
    uint256 private immutable i_entranceFee;

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaflle()  public payable {
        //require(msg.value>=i_entranceFee,"Not enough ETH sent!"); not eficiente
        //require(msg.value>=i_entranceFee,SendMoreEnterRAffle()); just in some versions and not efiencient enough
        if(msg.value<i_entranceFee){
            revert Raffle__SendMoreEnterRaffle();
        }
    }

    function pickWinner() public {
        
    }

    /** Getter Functions */
    function getEntranceFee() public view returns(uint256) {
        return i_entranceFee;
    }
}