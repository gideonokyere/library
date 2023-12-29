// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.20;

import '../interfaces/IERC20.sol';

contract ERC20 is IERC20 {

  string private _name;
  string private _symbol;
  uint private constant _decimals = 18;
  uint256 private _totalSupply;
  address public owner;

  event Transfer(address indexed _from, address indexed _to, uint256 amount);
  event Approve(address indexed _owner, address indexed _spender, uint256 amount);

 // Keep tracks of token balance of an account
  mapping (address => uint) _balances;

  // Keeps tracks of tokens and account is allowed to spend on behave on another account
  mapping (address => mapping (address => uint)) _allowances;

  constructor(string memory name_, string memory symbol_, uint256 initialSupply_){
    owner = msg.sender;
    _name = name_;
    _symbol = symbol_;
    _totalSupply = initialSupply_ ** _decimals;
    _mint(owner,initialSupply_);
  }

  /** returns the name of the token */
  function name() public virtual view returns (string memory) {
    return _name;
  }

  function symbol() public virtual view returns (string memory) {
    return _symbol;
  }

  /** Returns the balance of an account */
  function balanceOf(address account) public virtual view returns(uint256){
    return _balances[account];
  }

  /** Returns the total tokens in circulation */
  function totalSupply() public virtual view returns (uint256) {
    return _totalSupply;
  }

  /*** Get the balance of tokens an account is allowed to spend on behave of another account */
  function allowance(address _owner, address spender) public virtual view returns (uint256) {
    return _allowances[_owner][spender];
  }

  /**
   * @dev Transfer a token to an account
   * address recipiant - the address recieving the token
   * uint256 amount - the amount of token sending
   */
  function transfer(address recipient, uint256 amount) external virtual returns (bool) {
    address sender = msg.sender;
    _safeTransfer(sender,recipient,amount);
    return true;
  }

  function transferFrom(address _from, address _to, uint256 amount) external virtual returns (bool){
    address spender = msg.sender;
    uint256 allowanceBalance = allowance(_from,spender);
    require(_from != address(0), "Can not transfer token to zero address");
    require(_to != address(0), "Can not transfer token to zero address");
    require(allowanceBalance >= amount,'Insuficient funds');
    _allowances[_from][spender]-=amount;
    _balances[_to]+=amount;
    emit Transfer(_from,_to,amount);
    return true;
  }

  
  function approve (address spender, uint256 amount) external virtual returns (bool){
    address _owner = msg.sender;
    _approve(_owner,spender,amount);
    return true;
  }

  /**
   * @dev this function will be involke in the parent contract constructor
   * address owner - Owner of the contract
   * uint256 initialSupply - the total supply of token during contract creation
   */
  function _mint(address _owner,uint256 initialSupply) internal virtual {
    require(owner != address(0) && msg.sender == owner,"Zero address not allowed");
    _balances[_owner]+=initialSupply;
    _totalSupply+=initialSupply;
  }

  function _safeTransfer(address _from, address _to, uint256 amount) internal {
    require(_beforeTransfer(_from,_to,amount),"Transaction faild");
    _balances[_from]-=amount;
    _balances[_to]+=amount;
    emit Transfer(_from, _to, amount);
  }

/**
 * @dev this method checks for zero address and low balance
 * address account - checks to see if it is not a zero address
 * uint256 amount - checks to see if an account balance >= amount
 */
  function _beforeTransfer(address _from, address _to,uint256 amount) internal virtual returns (bool){
    uint256 fromBalance = _balances[_from];
    require(_from != address(0), "Can not transfer token to zero address");
    require(_to != address(0), "Can not transfer token to zero address");
    require(fromBalance >= amount,"Insuficiant funds");
    return true;
  }

   /**
    * @dev checks for zero address from both owner and spender. It's also emit the Aprove event
    */
  function _approve(address _owner, address spender, uint256 amount) internal {
    require(owner != address(0) && spender != address(0));
    _allowances[_owner][spender]+=amount;
    emit Approve(_owner,spender,amount);
  }
}