// import the contract artifact
const CoShoe = artifacts.require('./CoShoe.sol')

const truffleAssert = require('truffle-assertions')

// test starts here
contract('CoShoe', function (accounts) {
    // predefine the contract instance
    let CoShoeInstance
  
    // before each test, create a new contract instance
    beforeEach(async function () {
      CoShoeInstance = await CoShoe.new()
    })

    // first test:
    it('should check if 100 token are minted on deployment', async function () {
      //minter is a public variable in the contract so we can get it directly via the created call function
      let balanceOf = await CoShoeInstance.balanceOf(accounts[0])
      //check whether minter is equal to account 0
      assert.equal(balanceOf.toNumber(), 100, '100 coins are not minted at deployment')
    })

     // second test:
     it('should check if the buyShoe function works correctly', async function () {
      //correctly transfers ownership
      await CoShoeInstance.buyShoe('shoe1', 'shoe1.com', {'from':accounts[1], 'value': 0.5 *10 **18} )
      //let shoebought = await CoShoeInstance.buyshoe(accounts[1])
      let shoes = await CoShoeInstance.shoes(1)
      //console.log(buyshoe)
      //console.log(accounts[1])
      assert.equal(shoes.owner, accounts[1], "Ownership of shoe1 is not transferred correctly")
      assert.equal(shoes.name, 'shoe1', "Shoe's name is not properly set")
      assert.equal(shoes.image, 'shoe1.com', "Shoe's image is not properly set")
      assert(shoes.sold, "shoe1 is not successfully sold")
      //updates soldshoes count
      let shoesold = await CoShoeInstance.shoesSold()
      assert.equal(shoesold.toNumber(), 2, "sould shoes stock count is not updated")
    })
      
     // third test:
     it('should not be able to buy a shoe if the price is not equal to 0.5 ether', async function () {
      //reverts if the price is not equal to 0.5 ether
      await truffleAssert.reverts(CoShoeInstance.buyShoe('shoe1', 'shoe1.com', {'from':accounts[1], 'value': 2} ))
    
    })

    // fourth test:
    it('should check that checkPurchases returns the correct number of trues', async function() {
      await CoShoeInstance.buyShoe('shoe1', 'shoe1.com', {'from':accounts[1], 'value': 0.5 * 10 **18})
        let checkpurchases = await CoShoeInstance.checkPurchases()
        var count = 0
        for (var i = 0; i < checkpurchases.length; i++){
            if (checkpurchases[i] == true){
                count++
            }
        }
      assert.equal(count,1, "check purchases does not return the corret number of trues");
    })
})