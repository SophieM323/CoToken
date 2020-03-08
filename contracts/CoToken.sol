pragma solidity >=0.5.0;

import "./ERC20.sol";
import "./Ownable.sol";
import "./IBondingCurve.sol";


contract CoToken is ERC20, Ownable {

  using SafeMath for uint256;

  uint256 constant public scale = 10**18;

  // Total supply of fungible Co Tokens (CoT)
  uint256 public _totalSupply = 100;

  //The Bonding Curve function: f(x) = 0.01x + 0.2
  uint256 Price = (0.01 * (scale) * _amountofCoT) + 0.2;

  mapping (address => uint256) private _balances;

  constructor () public {
      _balances[msg.sender] = _totalSupply;
    }

    function buyPrice(uint256 _amountofCoT) public pure returns (uint256) {

      uint256 newBuyPrice = (0.01 * (scale) * _amountofCoT) + 0.2;

      return newBuyPrice;
    }

    function buyPrice(uint256 _amountofCoT) public pure returns (uint256) {

     uint256 newsellPrice = (0.01 * (scale) * _amountofCoT) + 0.2;

     return newsellPrice;
    }

    // functiion that transfers tokens from one address to another
    function transferFrom(address from, address to, uint _amountofCoT) public {
        _balances[from] -= _amountofCoT;
        _balances[to] += _amountofCoT;
        _totalSupply -= _amountofCoT;
    }

    /**
   * @dev function that mints an amount of the token and assigns it to
   * an account. This encapsulates the modification of balances such that the
   * proper events are emitted.
   * @param account The account that will receive the created tokens.
   * @param amount The amount that will be created.
   */
    function _mint(address _to, uint256 _amountofCoT) public payable {
     require(_to != 0);
     require(buyPrice(_amountofCoT) == msg.value, 'The wrong price is transferred to the contract');

     //calculates the new total supply after minting new CoT
     _totalSupply = _totalSupply.add(_amountofCoT);
     _balances[_to] = _balances[_to].add(_amountofCoT);
     emit Transfer(address(0), _to, _amountofCoT);
    }

  /**
   * @dev function that burns an amount of the token of a given
   * account.
   * @param account The account whose tokens will be burnt.
   * @param amount The amount that will be burnt.
   */
    function _burn(address _from, uint256 _amountofCoT) public onlyOwner payable {
     require(_from != 0);
     require(_amountofCoT <= _balances[_from]);

     //calculates the new total supply after burning CoT
     _totalSupply = _totalSupply.sub(_from);
     _balances[_from] = _balances[_from].sub(_numberofCoT);
     emit Transfer(_from, address(0), _numberofCoT);
    }

    function destroy() public onlyOwner {
    // function can only be called if all CoT belong to the owner
     require(_balances[msg.sender] ==_totalSupply);
        selfdestruct(msg.sender);
    }

}