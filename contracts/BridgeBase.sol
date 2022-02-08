pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';
import './Itoken.sol';

contract BridgeBase {
    address public admin;
    Itoken public token; //the token on the respective side of the bridge
    uint public nonce; //avoid to process the same transaction twice
    mapping(uint => bool) public processed; //same stuff
    
    enum Step { Burn, Mint }
    event Transfer(
        address from,
        address to,
        uint amount,
        uint date,
        uint nonce,
        Step indexed step
    );
    
    constructor(address _token) {
        admin = msg.sender;
        token = Itoken(_token);
        // nonce = 0;
        // processed = {};
    }

    function burn(address to, uint amount) external {
        token.burn(msg.sender, amount);
        emit Transfer(msg.sender, to, amount, block.timestamp, nonce, Step.Burn);
        nonce++;
    }
}