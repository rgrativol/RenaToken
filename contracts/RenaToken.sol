pragma solidity ^0.4.17;


import "./BurnableToken.sol";
import "./Ownable.sol";


/**
 * @title RenaToken
 * @dev Standard ERC20 "Rena Token" with symbol "RENA", 2 decimals and total supply of 100,000 units 
 * created at contract deployment and assigned to a specific wallet. Burnable Token, which can be 
 * irreversibly destroyed, ERC20 Token, where all tokens are pre-assigned to the creator.
 */
contract RenaToken is BurnableToken, Ownable {
    string public constant name = "RenaToken";
    string public constant symbol = "RENA";
    uint8 public constant decimals = 2;
    uint256 public constant INITIAL_SUPPLY = 100000 * 10**2;
    mapping(address => uint) public transferAllowedDates;

    /**
     * @dev Constructor that gives msg.sender all of existing tokens.
     */
    function RenaToken() public {
      	totalSupply_ = INITIAL_SUPPLY;
        balances[msg.sender] = INITIAL_SUPPLY;
        Transfer(0x0, msg.sender, INITIAL_SUPPLY);
    }

    modifier onlyAfterAllowedDate(address _account) {
        require(now > transferAllowedDates[_account]);
            _;
    }

    /**
    * @dev Owner can distribute tokens as they wish using `transfer` and others `StandardToken` functions.
    **/
    function distributeToken(address _to, uint _value, uint _transferAllowedDate) public onlyOwner {
        transferAllowedDates[_to] = _transferAllowedDate;
        super.transfer(_to, _value);
    }

    function transfer(address _to, uint _value) public onlyAfterAllowedDate(msg.sender) returns (bool) {
        return super.transfer(_to, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public onlyAfterAllowedDate(_from) returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }
   
}