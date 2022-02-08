pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenBase is ERC20 {
    address public admin;

    constructor(string memory name, string memory symbol) ERC20 (name, symbol){
        admin = msg.sender;
    }

    function updateAdmin(address newAdmin) external {
        require(msg.sender == admin,'Only admin can update admin');
        admin = newAdmin;
    }

    function mint(address reciever, uint amount) external {
        require(msg.sender == admin,'Only admin can mint');
        _mint(reciever, amount);
    }

    function burn(address reciever, uint amount) external {
        require(msg.sender == admin,'Only admin can burn');
        _burn(reciever, amount);
    }
}