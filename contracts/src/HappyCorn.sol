//SPDX-License-Identifier:MIT

pragma solidity 0.8.23;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract HappyCorn is Ownable,ReentrancyGuard, ERC721 {
    uint256 constant MAXDELIVERYTIME = 24 hours;
    uint256 constant FEE_NUMERATOR = 1;
    uint256 constant FEE_DENOMINATOR = 200;
    uint256 private itemIdCounter;

    struct Item {
        uint256 id;
        string name;
        string[3] imageIPFSHashes;
        uint256 price;
        address payable seller;
        bool isCustom;
        uint160 deliveryTime;
    }

    struct Order {
        uint256 itemId;
        address payable buyer;
        address payable seller;
        string deliveryHash;
        bool delivered;
        uint purchaseTime;
    }

    mapping(uint256 => Item) public items;
    mapping(address => uint256) public balances;
    mapping(uint256 => Order) public orders;

    event CreatedItem(uint256 indexed id, address indexed seller);
    event RemovedItem(uint256 indexed id);
    event BalanceWithdrawn(address indexed seller, uint256 indexed amount);
    event OrderedItem(uint256 indexed id, address indexed buyer, address indexed seller);
    event DeliveredItem(string indexed deliveryHash, address indexed buyer, address  indexed seller, uint256 id);
    event RefundedOrder(uint256 indexed id, address indexed buyer, address indexed seller);
    event PurchaseCompleted(uint256 indexed id, string deliveryhash, address indexed buyer);
    event NFTMinted(uint256 indexed tokenId, address indexed to, uint256 itemid);

    constructor() Ownable(msg.sender) ERC721("HappyCorn", "HAPPY") {
       
    }

    modifier onlySeller(uint256 _itemId) {
        require(msg.sender == items[_itemId].seller, "only seller can delete");
        _;
    }

    function updateowner(address _newowner) external {
        transferOwnership(_newowner);
    }

    // Done
    function createItem(
        string memory _name,
        string[3] memory _imageIPFSHashes,
        uint256 _price,
        bool _isCustom,
        uint160 _deliveryTime
    ) external {
        require(bytes(_name).length > 0 && _price > 0, "Inputs must be non-zero");
        require(_deliveryTime <= MAXDELIVERYTIME, "Invalid delivery time");
        itemIdCounter++;
        if (_isCustom) {
            items[itemIdCounter] = Item({
                id: itemIdCounter,
                name: _name,
                imageIPFSHashes: _imageIPFSHashes,
                price: _price,
                seller: payable(msg.sender),
                isCustom: _isCustom,
                deliveryTime: 0
            });
        } else {
            items[itemIdCounter] = Item({
                id: itemIdCounter,
                name: _name,
                imageIPFSHashes: _imageIPFSHashes,
                price: _price,
                seller: payable(msg.sender),
                isCustom: _isCustom,
                deliveryTime: _deliveryTime
            });
        }

        emit CreatedItem(itemIdCounter, msg.sender);
    }

    // Done
    function removeItem(uint256 _itemId) external onlySeller(_itemId) {
        delete items[_itemId];
        emit RemovedItem(_itemId);
    }

    function withdrawEarnings() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "no balance to withdraw");
        balances[msg.sender] = 0;
        emit BalanceWithdrawn(msg.sender, amount);
        (bool success, ) = msg.sender.call{value:amount}("");
        require(success, "Withdrawal failes");

        
    }
    //non-custommade purchase

    function BuyItem(uint256 itemId) external payable nonReentrant {
        Item storage item = items[itemId];
        require(msg.value >= item.price);

            uint256 feeAmount = (msg.value * FEE_NUMERATOR) / FEE_DENOMINATOR;
            balances[msg.sender] = msg.value - feeAmount;
            string memory deliveryhash = item.imageIPFSHashes[2];
            emit PurchaseCompleted(itemId, deliveryhash,msg.sender);

        }


    //custompurchase
    function BuyCustomItem(uint256 _itemId) external payable {
        Item storage item = items[_itemId];
        require(msg.value >= item.price, "Incorrect amount sent");
        require(item.isCustom, "This not a custom product");

        Order memory order = Order(_itemId, payable(msg.sender), item.seller,"", false, block.timestamp);
        emit OrderedItem(order.itemId, msg.sender, item.seller);
    }

    function deliverItem(uint256 _itemId, string memory _deliveryHash) external payable {
        Order storage order = orders[_itemId];
        require(order.seller == msg.sender, "Not the seller");
        require(!order.delivered);
        require(items[order.itemId].deliveryTime <= block.timestamp - order.purchaseTime, "");

        order.delivered = true;
        order.deliveryHash = _deliveryHash;
        emit DeliveredItem(_deliveryHash, order.buyer, order.seller,_itemId); 
        uint256 feeAmount = (msg.value * FEE_NUMERATOR) / FEE_DENOMINATOR;
        balances[msg.sender] = msg.value - feeAmount;
    }

    function refundOrder(uint256 _itemId) external { 
         Order storage order = orders[_itemId];
        require(order.buyer == msg.sender);
        require(order.delivered == false);
        order.delivered = true;
        order.buyer.transfer(items[_itemId].price);
        emit RefundedOrder(_itemId, order.buyer, order.seller);
    }
     // stucked here
    function mintNFT(uint256 _itemId, string memory deliveryhash) external nonReentrant {
        Order storage order = orders[_itemId];
        require(order.buyer == msg.sender);
        require(order.delivered);
        uint256 tokenId = uint256(keccak256(abi.encodePacked(deliveryhash, block.timestamp)));


        _safeMint(msg.sender, tokenId);
        emit NFTMinted(tokenId, msg.sender, _itemId);
    }

    //reads
    function getItemDetails(uint256 id)
        public view
        returns (
            string memory name,
            string[3] memory imageIPFSHashes,
            uint256 price,
            address seller,
            bool isCustom,
            uint160 deliveryTime
        )
    {
        Item memory item = items[id];
        return (
            item.name,
            item.imageIPFSHashes,
            item.price,
            item.seller,
            item.isCustom,
            item.deliveryTime
        );
    }

    function getsellerbalance(address seller) external view returns (uint256) {
        require(msg.sender == seller);
        return balances[seller];
    }
    function getAllItems() external view returns (Item[] memory) {
    Item[] memory allItems = new Item[](itemIdCounter);
    for (uint256 i = 1; i <= itemIdCounter; i++) {
        allItems[i - 1] = items[i];
    }
    return allItems;
}

}
