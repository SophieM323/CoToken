pragma solidity >=0.5.0;

contract CoShoe {

    struct Shoe {
        address payable owner;
        string name;
        string image; //url to the image
        bool sold;
    }
    //1 ether is equal to 10^18 wei//
    uint price = 0.5 * (10 ** 18);

    //state variable that holds the number of shoes that have already been sold
    uint public shoesSold = 0;

    Shoe[] public shoes;

    //minting coins
    //new
    address public minter;
    mapping (address => uint) public balanceOf;

    constructor () public {
        minter = msg.sender;

        Shoe memory shoe0;
        shoe0.owner = msg.sender;
        shoe0.name = "";
        shoe0.image = "";
        shoe0.sold = false;

        balanceOf[msg.sender] = 100;

        //adding the instance of shoe1 to the shoes array
        shoes.push(shoe0);
        shoesSold++;
    }


    function buyShoe(string memory name, string memory image) public payable {
        require(shoesSold > 0 || shoesSold <= 100, "There are no shoes available in stock");
        require(price == msg.value, "The value does not match the price of the shoe");
        bool sold = true;
        shoes.push(Shoe(msg.sender, name, image, sold));
        shoesSold++;
    }

    function checkPurchases() public view returns (bool[]memory) {
        bool[] memory truearray = new bool[](shoesSold);
        bool sold;
        for (uint i = 0; i < shoesSold; i++){
            Shoe storage shoeOwner = shoes[i];
            if (shoeOwner.owner == msg.sender){
                sold = true;
                truearray[i] = sold;
            }
            else {
                sold = false;
                truearray[i] = sold;
            }
        }
        return truearray;
    }

}