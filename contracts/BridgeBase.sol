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
    //Anyone can call the burn function
    function burn(address to, uint amount) external {
        token.burn(msg.sender, amount);
        emit Transfer(msg.sender, to, amount, block.timestamp, nonce, Step.Burn);
        nonce++;
    }
    //Only Admin can call the mint: Bridge API
    function mint(address to, uint amount, uint otherChainNonce) external {
        require(msg.sender == admin,'Only admin can mint');
        require(processed[otherChainNonce] == false, 'Transaction already processed');
        processed[otherChainNonce] == true; //make processed
        token.mint(to, amount); //mint on the other side
        emit Transfer(msg.sender, to, amount, block.timestamp, otherChainNonce, Step.Mint);
    }
}