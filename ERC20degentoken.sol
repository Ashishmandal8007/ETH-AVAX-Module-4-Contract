// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract deganToken is ERC20, Ownable {
    string[] public sportIteams;

    constructor() ERC20("Degan", "DGN") {
        sportIteams = new string[](4);
        sportIteams[0] = "Bat";
        sportIteams[1] = "Pad";
        sportIteams[2] = "Helmet";
        sportIteams[3] = "Ball";
    }

    function mintTokens(address recipient, uint256 amount) external onlyOwner {
        _mint(recipient, amount);
    }

    // Transferring tokens: Players can transfer their tokens to others.
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(recipient != address(0), "ERC20: transfer to the zero address");
        return super.transfer(recipient, amount);
    }

//Redeeming tokens: Players should be able to redeem their tokens for items in the in-game store.
    function redeemToken(uint256 itemId, uint256 amount) public payable {
        require(bytes(sportIteams[itemId]).length > 0, "Iteam does not exist");
        require(balanceOf(msg.sender) >= amount, "You have not sufficient amount to buy");
    }

    function checkTokenBalance(address account)external view returns (uint256) {
        return balanceOf(account);
    }
//Burning tokens: Anyone should be able to burn tokens, that they own, that are no longer needed.
    function burntoken(uint256 amount) public {
        _burn(msg.sender, amount);
    }

// transferItems: Players should be able to transfer their items game.
    function transferItems(address to, uint256 itemId ) public {
        require(bytes(sportIteams[itemId]).length > 0, "Iteam does not exist");
        _transfer(_msgSender(), to, itemId);
    }

}

