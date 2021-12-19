pragma solidity ^0.8.0;


contract Bank {
    struct AccountRecords {
        uint customer_ID;
        string customer_name;
        string customer_profession;
        string customer_DOB;
        string Wallet_Address;
        uint number_of_accounts;
    }
    mapping(address=>uint) account_balances;
    AccountRecords[] public account_records;
    mapping(address=>uint) account_information;
    uint number_of_accounts = 0;

    function registerAccount (string memory customer_name,string memory customer_ID) public returns (bool) {
    require (account_information[msg.sender] < 1, "Account is already exist!");
    number_of_accounts += 1;

    }

    modifier onlyRegistered() {
        require(account_information[msg.sender] > 0, "Account must be registered");
        _;
    }

    function getAccountInfo () public onlyRegistered view returns (AccountRecords memory) {
        return account_records [account_information[msg.sender]-1];
        
    }
    
    function transfer(address account_to_transfer, uint amount) public onlyRegistered returns (bool) {
    require (account_balances[msg.sender]>amount, "Insufficient Funds");
    account_balances[msg.sender] -= amount;
    account_balances[account_to_transfer]+= amount;
    return true;

    }

    function withdraw(uint amount) public onlyRegistered returns (bool) {
    require (account_balances[msg.sender]>=amount, "Insufficient Funds");
    account_balances[msg.sender] -= amount; 
    payable(msg.sender).transfer(amount);
    return true;

    }

    receive () external payable {
        account_balances[msg.sender] += msg.value;   
    }
}

