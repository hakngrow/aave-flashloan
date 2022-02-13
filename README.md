## Making a Aave Flash Loan

### 1. About Aave

> Aave is an open source and non-custodial liquidity protocol for earning interest on deposits and borrowing assets.

Aave is like a decentralized pseudo-bank. Instead of a central bank that validates all of the transactions, Aave has smart contracts to automated all of this work. Depositors put their tokens into Aave, and begin earning interest on their deposit. Borrowers, on the other hand, will take tokens out of Aave and will begin accruing interest on the amount borrowed. In order to do this, they must be [overcollateralized](https://www.investopedia.com/terms/o/overcollateralization.asp).

There is another method for those that don’t want to deposit tokens into Aave, and just want to borrow. This is the flash loan that this tutorial is about.

### 2. About Flash Loans
Flash loans are a new way of borrowing assets on the blockchain. Initially implemented by Aave, other trending DeFi protocols such as [dYdX](https://dydx.exchange/) quickly added this feature. There is a property that all Ethereum transactions share that enable flash loans to be possible. And this key feature is atomicity.

A transaction is atomic if the series of its operations are indivisible and irreducible. In other words — either all or none of the transaction occurs. The flash loan leverages atomicity to allow a user to borrow without posting collateral. There are two caveats to mention. First of all, whenever you borrow an asset in a flash loan you have to pay a fee of 0.09% of the amount loaned. Secondly, you must pay back the loan in the same transaction in which you borrowed. Flash loans are primarily used for arbitrage between assets.

### 3. Remix Setup

For this tutorial, we'll be using [Remix](https://remix.ethereum.org/), the browser based IDE. 

![Remix IDE](./public/images/remix-ide.jpg)

### 4. Metamask Setup

MetaMask is a browser plugin that serves as an Ethereum wallet. Once installed, it allows users to store Ether and other ERC-20 tokens, enabling them to make transactions to any Ethereum address.

You can install MetaMask [here](https://metamask.io/).

### 5. The Smart Contract

Create the following 6 files in the `contracts` folder in your `default_workspace` of Remix.

- FlashLoan.sol
- FlashLoanReceiverBase.sol
- IFlashLoanReceiver.sol
- ILendingPoolAddressesProvider.sol
- ILendingPool.sol
- Withdrawable.sol

![contracts folder](public/images/contracts.jpg)

Our flash loan contract (`FlashLoan.sol`) inherits from the [abstract contract](https://docs.soliditylang.org/en/v0.6.2/contracts.html#abstract-contracts) `FlashLoanReceiverBase.sol`. An abstract contract is used as base contract so that the child contract can inherit and utilize its functions.

To receive flash loaned amounts, our contract must conform to the `IFlashLoanReceiver.sol` interface by implementing the relevant `executeOperation()` function.

`ILendingPool.sol` and `ILendingPoolAddressesProvider.sol` are [interfaces](https://www.geeksforgeeks.org/solidity-basics-of-interface/) that allow our flash loan contract to interact with the Aave market.

Next we break down the code in our flash loan contract `FlashLoan.sol`.

`pragma solidity ^0.6.6;`


First, we define the solidity compiler version (`0.6.6`).

`import "./FlashLoanReceiverBase.sol";`
`import "./ILendingPool.sol";`

Then, we import the dependencies for the smart contract. The flash loan contract is inheriting from the `FlashLoanReceiverBase` abstract contract.

`constructor(address _addressProvider) FlashLoanReceiverBase(_addressProvider) public {}`

To instaniate the flash loan contract, we need to pass it the address of one of the [Lending Pool Addresses Provider](https://docs.aave.com/developers/v/1.0/deployed-contracts/deployed-contract-instances) of Aave.  For this tutorial, V1 contracts from the Kovan testnet.

```
    function flashloan() public onlyOwner {
        /**
        * Flash Loan of 1000 DAI
        */
        address receiver = address(this); // Can also be a separate contract
        address asset = "0x6b175474e89094c44da98b954eedeac495271d0f"; // Dai
        uint256 amount = 1000 * 1e18;
        
        // If no params are needed, use an empty params:
        bytes memory params = "";
        // Else encode the params like below (bytes encoded param of type `address` and `uint`)
        // bytes memory params = abi.encode(address(this), 1234);
        
        ILendingPool lendingPool = ILendingPool(addressesProvider.getLendingPool());
        lendingPool.flashLoan(address(this), asset, amount, params);
    }
```

We define a `flashloan()` function
