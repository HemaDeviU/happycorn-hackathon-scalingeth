//SPDX-License-Identifier:MIT

pragma solidity 0.8.23;

contract HappyCorn {
    address private  owner;
    address[] private sellers;
    uint256 private immutable MAXDELIVERYTIME = 24 hours;
    
    event CreatedItem(uint256 indexed itemid,address indexed seller);
    struct Item {
    
        string name;
        string[] imageurls;
        uint256 price;
        address seller;
        bool isCustommade;
        bool active;
        uint256 deliveryTime;
    }
    mapping(uint256 => Item) public items;

    constructor(){

    }
    struct Order {
        bool deliverystatus;
        


    }
    function createItem(string memory _name, string[] memory _imageurls, uint256 price, bool _isCustom, uint256 _deliveryTime) external {
        require(bytes(_name).length > 0, "Name must be non-zero");
        require(_imageurls.length > 0 && imageurls.length <=3,"Inavlid number of hashes");
        require(_deliveryTime >= MAXDELIVERYTIME);
        Item memory newItem = Item({name: _name,
        imageurls: _imageurls,
        price: _price,
        seller: msg.sender,
        isCustommade: _isCustom,
        active: true,
        deliveryTime: _deliveryTime});
        uint256 itemid = uint256(keccak256(abi.encodePacked(_name, msg.sender, block.timestamp)));
        items[itemid] = newItem;
        emit CreatedItem(itemid, msg.sender);


    }








    function removeItem() onlySeller {}

    function updatelisting() onlySeller {}

    function updateselleraddress() onlySeller {}

    function fulfillitemAndMintNft() onlySeller {}

    function withdrawEarnings() onlySeller {}

    function purchaseitem() {}

    function refundPurchase() {}

    //reads
    function getOrderstatus(){}
    function getItems() {}
    function getseller() {}
    function getsellerbalance() {}
    


}
