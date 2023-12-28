interface IERC20 {
  /** The total number of tokens in circulations */
  function totalSupply() external view returns (uint256);

  /*** Return token balance of an account */
  function balanceOf(address account) external view returns (uint256);

  /** Transfer a token from one account to another account */
  function transfer(address recipient, uint256 amount) external returns(bool);

  /** Approve an account to spend a token on your behave */
  function approve(address spender, uint256 amount) external returns (bool);

  /** After allowing an account to spend a token on your behave, they can use this method to transfer tokens */
  function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

  /** Get the total token approved account can spent */
  function allowance(address owner, address spender) external view returns (uint256);

/** Emit when a transfer is made */
  Event Transfer(address indexed _from, address indexed _to, uint256 amount);

  /**Emit when an account get approved */
  Event Approve(address indexed _owner, address indexed _spender, uint256 amount);
}