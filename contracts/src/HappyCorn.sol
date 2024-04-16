//SPDX-License-Identifier:MIT

pragma solidity 0.8.23;

contract HappyCorn {
    address public  owner;
    address[] public sellers;
    
    struct Item {
        uint256 itemid;
        string name;
        string[] imageurls;
        uint256 price;
        address seller;
        bool isCustommade;
        bool active;
        uint256 deliveryTime;
    }
    constructor(){

    }
    struct Order {
        bool deliverystatus;


    }
    function createItem() onlySeller {}

    function removeItem() onlySeller {}

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
