//SPDX-License-Identifier:MIT

pragma solidity 0.8.23;
import "./HappyCorn.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";


contract Escrow{
    constructor(address buyer, address seller, Item id, uint256 ordertime, uint256 deliveryinterval, uint256 price, uint256 orderid)
    {

    }
    function fulfillorder(_id, ipfshash) onlyseller public returns ()
    {
        require(block.timestamp <= ordertime + deliveryinterval)
        CID = _ipfshash;
    }
    function mintNFT() public
    {
        
    }
}