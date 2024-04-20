//SPDX-License-Identifier:MIT

pragma solidity 0.8.23;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract HappyCorn is ReentrancyGuard, ERC721 {
    address private owner;
    uint256 constant MAXDELIVERYTIME = 24 hours;
    // uint256 constant FEE_NUMERATOR = 1;
    // uint256 constant FEE_DENOMINATOR = 200;
    uint256 private itemIdCounter;
    uint256 private OrderId;

    struct Item {
        uint256 id;
        string name;
        bytes32[2] imageurls;
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
    mapping(address => uint256[]) addressToOrderItem; // address to orderIds

    event CreatedItem(uint256 indexed id, address indexed seller);
    event RemovedItem(uint256 indexed id);
    event BalanceWithdrawn(address indexed seller, uint256 indexed amount);
    event OrderedItem(uint256 indexed id, address indexed buyer, address indexed seller);
    event DeliveredItem(uint256 indexed id, address indexed buyer, address indexed seller);
    event RefundedOrder(uint256 indexed id, address indexed buyer, address indexed seller);
    event PurchaseCompleted(uint256 indexed id, address indexed buyer);
    event NFTMinted(uint256 indexed tokenId, address indexed to);

    constructor() ERC721("HappyCorn", "HAPPY") {
        owner = msg.sender;
    }

    modifier onlySeller(uint256 _itemId) {
        require(msg.sender == items[_itemId].seller, "only seller can delete");
        _;
    }

    function updateowner(address _newowner) external {
        require(msg.sender == owner, "Only owner can call this function");
        owner = _newowner;
    }

    // Done
    function createItem(
        string memory _name,
        bytes32[] memory _imageurls,
        uint256 _price,
        bool _isCustom,
        uint256 _deliveryTime
    ) external {
        require(bytes(_name).length > 0 && _price > 0, "Inputs must be non-zero");
        require(_imageurls.length > 0 && _imageurls.length <= 3, "Inavlid number of hashes");
        require(_deliveryTime <= MAXDELIVERYTIME, "Invalid delivery time");
        itemIdCounter++;
        if (_isCustom) {
            items[itemIdCounter] = Item({
                id: itemIdCounter,
                name: _name,
                imageurls: _imageurls[],
                price: _price,
                seller: payable(msg.sender),
                isCustom: _isCustom,
                deliveryTime: 0
            });
        } else {
            items[itemIdCounter] = Item({
                id: itemIdCounter,
                name: _name,
                imageurls: _imageurls[],
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

        payable(msg.sender).transfer(amount);
    }
    //non-custommade purchase

    function BuyItem(uint256 itemId) public payable nonReentrant {
        Item storage item = items[itemId];
        require(msg.value >= item.price);

        if (item.isCustom) {
            BuyCustomItem(itemId);
        } else {
            uint256 feeAmount = (msg.value * 1) / 200;
            balances[msg.sender] = msg.value - feeAmount;
        }

        // emit the product hash
        // emit PurchaseCompleted(itemId, msg.sender);
    }

    //custompurchase
    function BuyCustomItem(uint256 _itemId) internal payable {
        Item storage item = items[_itemId];
        require(msg.value >= item.price, "Incorrect amount sent");
        require(item.isCustom, "This not a custom product");

        Order memory order = Order(_itemId, payable(msg.sender), item.seller, "", false, block.timestamp);
        uint256 feeAmount = (msg.value * 1) / 200;
        balances[msg.sender] += (msg.value - feeAmount);

        emit OrderedItem(_itemId, msg.sender, item.seller);
    }

    function deliverItem(uint256 _itemId, string memory _deliveryHash) external {
        Order storage order = orders[_itemId];
        require(order.seller == msg.sender, "Not the seller");
        require(!order.delivered);
        require(items[order.itemId].deliveryTime <= block.timestamp - order.purchaseTime, "");

        order.delivered = true;
        order.deliveryHash = _deliveryHash;
        emit DeliveredItem(_itemId, order.buyer, msg.sender); // emit the deliverHash here
    }

    function refundOrder(uint256 _itemId) external { // only owner when the order is not delivered within time
        Order storage order = orders[_itemId];
        require(order.buyer == msg.sender);
        order.refundedelivered = false;
        order.buyer.transfer(items[_itemId].price);
        emit RefundedOrder(_itemId, order.buyer, order.seller);
    }
     // stucked here
    function mintNFT(uint256 _itemId, string memory deliveryhash) external nonReentrant {
        Order storage order = Order[_itemId];
        require(order.buyer == msg.sender);
        require(order.delivered);

        _safeMint(msg.sender, deliveryhash);
        emit NFTMinted(deliveryhash, msg.sender);
    }

    //reads
    function getItemDetails(uint256 id)
        public
        returns (
            string memory name,
            bytes32[2] memory imageurls,
            uint256 price,
            address seller,
            bool isCustom,
            bool active,
            uint160 deliveryTime
        )
    {
        Item memory item = items[id];
        return (
            item.name,
            item.imageurls,
            item.price,
            item.price,
            item.seller,
            item.isCustom,
            item.active,
            item.deliveryTime
        );
    }

    function getsellerbalance(address seller) external {
        require(msg.sender == seller);
        return balances[seller];
    }
}
