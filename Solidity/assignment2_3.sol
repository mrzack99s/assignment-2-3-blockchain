pragma solidity >=0.4.22 <0.6.0;

contract COCOCharacterShop {
    
    
    struct COCOCharacter{
        uint id;
        string name;
        uint256 priceTag;
        address owner;
        string imagePath;
        bool haveOwner;
    }
    
    uint C_ID = 0;
    
    uint[] collectionCocoCharaterId;
    mapping (uint => COCOCharacter) cocoCharacter;
    event PurchaseCharacterErrorLog(address indexed buyer,string reason);
    event SoldCharacter(address indexed buyer,uint id);

    
    function addCharacter(string memory name,uint256 priceTag ,string memory imagePath) public returns(uint id){
        uint Id = C_ID++;
        
        cocoCharacter[Id] = COCOCharacter(Id,name, priceTag, address(0x0000000000000000000000000000000000000000), imagePath,false);
        collectionCocoCharaterId.push(Id);
        
        return Id;
    }
    
    function sellCharacter(uint id) public payable returns(bool){
        if(msg.value < cocoCharacter[id].priceTag){
            emit PurchaseCharacterErrorLog(msg.sender,"Error, invalid value !!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
        if(cocoCharacter[id].haveOwner){
            emit PurchaseCharacterErrorLog(msg.sender,"Error, this character is have owner!!");
            msg.sender.transfer(msg.value);
            return false;
        }
        
        cocoCharacter[id].owner = msg.sender;
        cocoCharacter[id].haveOwner = true;
        emit SoldCharacter(msg.sender,id);
        
        return true;
    }
    
    function getChracterById(uint Id) public view returns(uint,string memory,uint256,address,string memory,bool){
        return (cocoCharacter[Id].id,cocoCharacter[Id].name,cocoCharacter[Id].priceTag,cocoCharacter[Id].owner,cocoCharacter[Id].imagePath,cocoCharacter[Id].haveOwner);
    }
    
    function getAllCharacter() public view returns(uint[] memory){
        return collectionCocoCharaterId;
    }
    
    function getNextValId() public view returns(uint){
        return C_ID;
    }
    
}






