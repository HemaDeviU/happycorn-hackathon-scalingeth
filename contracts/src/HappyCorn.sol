//SPDX-License-Identifier:MIT

pragma solidity 0.8.23;

import "@openzeppelin/contracts/access/Ownable.sol";


contract HappyCorn {
    address private owner;
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
        uint160 deliveryTime;
    }

    mapping(uint256 => Item) public items;
    mapping(address => uint256) public balances;

    event CreatedItem(uint256 indexed id,address indexed seller);
    event RemovedItem(uint256 indexed id);
    event BalanceWithdrawn(address indexed seller, uint256 indexed amount);
    event PurchaseCompleted(id indexed,address indexed buyer);

    constructor(){
        owner = msg.sender;
    
    }
    function updateowner(_owner) onlyowner{
        owner = _newowner;
    }
    
    function createItem(string memory _name, bytes32[] memory _imageurls, uint256 price, bool _isCustom, uint256 _deliveryTime) external {
        require(bytes(_name).length > 0 && price > 0 ,"Name must be non-zero");
        require(_imageurls.length > 0 && _imageurls.length <=3,"Inavlid number of hashes");
        require(_deliveryTime >= MAXDELIVERYTIME);
        

        uint256 itemId = nextItemId;
        nextItemId++;
        Item memory newItem = Item({_name,_imageurls,_price,msg.sender,_isCustom,true,_deliveryTime});
        items[id] = newItem;
        emit CreatedItem(id, msg.sender);
    }

    function removeItem(id) external {
        require(items[id].seller == msg.sender || owner, "only seller can delete");
        delete items[id];
        emit RemovedItem(id);
    }

    function withdrawEarnings() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0), "no balance to withdraw";
        balances[msg.sender] = 0;
        emit BalanceWithdrawn(msg.sender, amount);

        payable(msg.sender).transfer(amount);
        
    }
    //non-custommade purchase
    function BuyItem(uint256 _id) payable {
        require(msg.value >= items[_id].price);
        
        uint256 feeAmount = (msg.value * FEE_NUMERATOR) / FEE_DENOMINATOR;
        balances[msg.sender] = msg.value - feeAmount;
        emit PurchaseCompleted(_id, msg.sender);

        return items[_id].imageurls[2];
    }
    

    //custompurchase
    function BuyCustomItem(_id)
    {//have to think about splitting the functions for ease
        //create an escrow to make sure the order is completed within deliverytime.
        //within the deliverytime, the seller must generate item's ipfs hash and update it to buyer
        //if the seller does this on time, the buyer also can mint the item to their wallet
        //if the seller fails to do this on time, the buyer is refunded the amount they paid 

    }

    
    //reads
    function getItemDetails(uint256 id)public returns (string,imageurls,price,seller,isCustom,active,deliveryTime){
        return (items[id].name,item[id].imageurls,item[id].price,item[id].price,item[id].seller,item[id].isCustom,item[id].active,item[id].delivertTime);
    }
    function getOrderstatus(){
        return 
    }
    function getsellerbalance(address seller) {
        return balances[seller];
    }



}
