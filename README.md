# Raffle Smart Contract

## Overview

This project is a decentralized, autonomous raffle contract built on Ethereum, designed to select a random winner at a specified time interval. The contract utilizes **Chainlink VRF v2.5** to securely generate a random number and **Chainlink Automation** to automate the selection process. The project is developed with **Foundry**, a powerful Ethereum development framework.

## Features

- **Automated Winner Selection**: Leveraging Chainlink Automation, the contract initiates winner selection at regular intervals.
- **Tamper-proof Randomness**: Uses Chainlink VRF v2.5 to ensure fair and verifiable randomness.
- **Efficient Gas Management**: Callback functions and errors are optimized for gas efficiency, ensuring smooth operation and reduced costs.

## Prerequisites

- **Foundry**: Installed and configured on your development environment.
- **Chainlink Account**: For VRF and Automation setup.
- **Ethereum Testnet Access**: (e.g., Sepolia or Goerli) for testing purposes.
- **.env File**: To store and manage environment variables securely.

### Environment Variables

Create a `.env` file to configure the following details:

```plaintext
SEPOLIA_RPC_URL=
ETHERSCAN_API_KEY=
PRIVATE_KEY= "it's prefer to use one manager of privite key"
```

## Installation and Setup

1. **Clone Repository**:
   ```sh
   git clone https://github.com/Doomsday1102/smart-contract-lotery.git
   cd smart-contract-lotery
   ```

2. **Install Dependencies**:
   ```sh
   forge install
   ```
3. **Install Librarys**:
```sh
make install
```

4. **Compile**:
   ```sh
   forge build
   ```

5. **Test**:
   ```sh
   forge test
   ```

6. **Deploy**:
   Deploy the smart contract to the Ethereum testnet, the two forms are equal
   ```sh
   forge create Raffle --rpc-url <RPC_URL> --private-key <PRIVATE_KEY>
   make deploy
   ```

## Contract Details

### Key Functions

- **enterRaffle**: Allows users to join the raffle by paying the entrance fee. Throws an error if insufficient funds are sent or if the raffle is closed.
  
- **checkUpkeep**: Called by Chainlink Automation to check if conditions are met to pick a winner. This function verifies:
  - Time interval has passed since the last raffle.
  - Raffle is open.
  - Contract has ETH and players.

- **performUpkeep**: Initiates the winner selection by requesting a random number from Chainlink VRF when upkeep conditions are met.

- **fulfillRandomWords**: Called by Chainlink VRF to provide the random number. It calculates the winner index, transfers the prize, and resets the raffle.

### Key Events

- **RaffleEntered**: Emitted when a user enters the raffle.
- **RequestedRaffleWinner**: Emitted upon requesting a random number from Chainlink VRF.
- **WinnerPicked**: Emitted when a winner is selected.

## Code Structure

### Constructor Parameters

- **entranceFee**: Minimum ETH required to join the raffle.
- **interval**: Time duration between each raffle.
- **vrfCoordinator**: Address of the Chainlink VRF coordinator.
- **gasLane**: Key hash for the gas lane.
- **subscriptionId**: Chainlink subscription ID for VRF.
- **callbackGasLimit**: Maximum gas limit for callback.

### Error Handling

- **Raffle__SendMoreToEnterRaffle**: Thrown if a player sends insufficient ETH.
- **Raffle_TransferFailed**: Thrown if prize transfer fails.
- **Raffle__RaffleNotOpen**: Thrown if a player attempts to join a closed raffle.
- **Raffle__UpkeepNotNeeded**: Thrown if upkeep conditions are not met.

## Testing

This project includes tests to verify:

- Players are able to join the raffle by paying the entrance fee.
- Chainlink Automation correctly triggers the raffle at specified intervals.
- Chainlink VRF provides a secure random number for winner selection.
- The contract transfers funds to the selected winner.

Run tests with:

```sh
forge test
```

## Deployment and Automation

1. Deploy the contract to the testnet of choice (e.g., Sepolia).
2. Set up Chainlink Automation to call `performUpkeep` at the interval specified during contract deployment.
3. Verify the functionality on Etherscan or your preferred blockchain explorer.

## Security Considerations

- **Randomness Security**: Chainlink VRF ensures tamper-proof random number generation.
- **Access Control**: Only authorized Automation nodes can trigger `performUpkeep`.
- **Error Handling**: Custom error messages optimize gas usage and provide clear debugging insights.

## License

This project is licensed under the MIT License.