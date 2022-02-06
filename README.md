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
