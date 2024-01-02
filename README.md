# library
This library will contain codes of solidity smart contracts and interfaces

# How to use this ERC20 standard protocol in your projects.

This contract has all the required methods be considered as ERC20 protocol.


**Required methods** 

 - **balanceOf (address account) -> uint256** - this method returns the balance of an account.
 - **transfer (address _from, address _to) -> bool** - this method allows _from account to send a token to _to account and should return a boolean  indicating a successful transaction.
 - **approve (address spender, uint256 amount) -> bool** - Allow an account to spend token on your behave by specifying the amount they can spend.
 - **transferFrom (address sender, address recipient, uint256 amount) -> bool** - After approving an account to spend a token on your behave, this method is use to transfer a token.
 - **allowance (address owner, address spender) -> uint256** - This method returns the token balance an account can spend on your behave.

**Optional Methods**

 - **name () -> string** - it returns the name of the token.
 - **symbol () -> string** - it returns the token symbol.
 - **totalSupply () -> uint256** - it returns the total supply of tokens in circulation.
 - **decimals () -> uint** - it returns the token decimal.
 
 # How to use it in your project.
 

    import "url to the contract file";
    contract MyToken is ERC20 {
       constractor(string _name, string _symbol) ERC20(_name,_symbol){};
       
       # you can now start calling the verious methods.
       
       function transferToken(address _from, address _to, uint256 amount) public returns (bool){
       (bool sent,) = transfer(_from,_to,amount);
       require(sent);
       }
    }


