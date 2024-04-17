//SPDX-License-Identifier:MIT

pragma solidity 0.8.23;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract HappyCorn {
    address private owner;
    address[] private sellers;
    uint256 constant MAXDELIVERYTIME = 24 hours;
    uint256 constant FEE_NUMERATOR = 1;
    uint256 constant FEE_DENOMINATOR = 200;

    uint256 private nextItemId = 1;
    
    struct Item {
        string name;
        bytes32[] imageurls;
        uint256 price;
        address seller;
        bool isCustom;
        bool active;
        uint160 deliveryTime;//60
    }

    mapping(uint256 => Item) public items;
    mapping(address => uint256) public balances;

    event CreatedItem(uint256 indexed itemid,address indexed seller);
    event RemovedItem(uint256 indexed itemid);
    event BalanceWithdrawn(address indexed seller, uint256 indexed amount);
    event PurchaseCompleted(itemid indexed,address indexed buyer);

    constructor(){
    
    }
    
    function createItem(string memory _name, bytes32[] memory _imageurls, uint256 price, bool _isCustom, uint256 _deliveryTime) external {
        require(bytes(_name).length > 0 && price > 0 ,"Name must be non-zero");
        require(_imageurls.length > 0 && imageurls.length <=3,"Inavlid number of hashes");
        require(_deliveryTime >= MAXDELIVERYTIME);

        uint256 itemId = nextItemId;
        nextItemId++;
        Item memory newItem = Item({_name,_imageurls,_price,msg.sender,_isCustom,true,_deliveryTime});
        items[itemid] = newItem;
        emit CreatedItem(itemid, msg.sender);
    }

    function removeItem(itemid) external {
        require(items[itemid].seller == msg.sender || owner, "only seller can delete");
        delete items[itemid];
        emit RemovedItem(itemid);
    }

    function withdrawEarnings() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0), "no balance to withdraw";
        balances[msg.sender] = 0;
        emit balancewithdrawn(msg.sender, amount);

        payable(msg.sender).transfer(amount);
        
    }
    //non-custommade purchase
    function Initiatepurchase(uint256 _itemid) payable {
        require(msg.value >= items[itemid].price);
        
        uint256 feeAmount = (msg.value * FEE_NUMERATOR) / FEE_DENOMINATOR;
        balances[msg.sender] = msg.value - feeAmount;
        emit Purchasecomplete(_itemid, msg.sender);

        return items[_itemid].imageurls[2];
    }
    

    //custompurchase
    function Inititatecustompurchase(_itemid)
    {//have to think about splitting the functions for ease
        //create an escrow to make sure the order is completed within deliverytime.
        //within the deliverytime, the seller must generate item's ipfs hash and update it to buyer
        //if the seller does this on time, the buyer also can mint the item to their wallet
        //if the seller fails to do this on time, the buyer is refunded the amount they paid 

    }

    function _refundPurchase() {}
    function updateowner(_owner) onlyowner{
        owner = _newowner;
    }
    //reads
    function getOrderstatus(){}
    function getItems() {}
    function getseller() {}
    function getsellerbalance() {}



}
