pragma solidity ^0.6.6;

import "./FlashLoanReceiverBase.sol";
import "./ILendingPoolAddressesProvider.sol";
import "./ILendingPool.sol";

contract Flashloan is FlashLoanReceiverBase {

    constructor(address _addressProvider) FlashLoanReceiverBase(_addressProvider) public {}

    /**
        This function is called after your contract has received the flash loaned amount
     */
    function executeOperation(
        address _reserve,
        uint256 _amount,
        uint256 _fee,
        bytes calldata _params
    )
        external
        override
    {
        require(_amount <= getBalanceInternal(address(this), _reserve), "Invalid balance, was the flashLoan successful?");

        //
        // Your logic goes here.
        // !! Ensure that *this contract* has enough of `_reserve` funds to payback the `_fee` !!
        //

        uint totalDebt = _amount.add(_fee);
        transferFundsBackToPoolInternal(_reserve, totalDebt);
    }

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
}