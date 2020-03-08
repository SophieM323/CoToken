// import the contract artifact
const CoToken = artifacts.require('./CoToken.sol')

const truffleAssert = require('truffle-assertions')

// test starts here
contract('CoToken', function (accounts) {
    // predefine the contract instance
    let CoTokenInstance
  
    // before each test, create a new contract instance
    beforeEach(async function () {
      CoTokenInstance = await CoToken.new()
    })

    // first test:
    it('should check if Co Tokens are minted and assigned to an account', async function () {
      //minter is a public variable in the contract so we can get it directly via the created call function
      let balanceTo = await CoShoeInstance.mint(accounts[1], 10)
      //check whether minter is equal to account 0
      assert.equal(balanceTo.toNumber(), 10, '10 coins are not minted and assigned to account 1')
    })

    // second test:
    it('should check if Co Tokens are minted and assigned to an account', async function () {
        //minter is a public variable in the contract so we can get it directly via the created call function
        let burntCoT = await CoShoeInstance.burn(accounts[0], 10)
        //check whether minter is equal to account 0
        assert.equal(burntCoT.toNumber(), 10, '10 coins are not burnt from account 0')


    // third test:
    it('should check if Co Tokens are minted and assigned to an account', async function () {
        //minter is a public variable in the contract so we can get it directly via the created call function
        let destroyedCoT = await CoShoeInstance.destroyed({'from':accounts[0]})
        //check whether minter is equal to account 0
        assert.equal(destroyedCoT, accounts[0], 'account 0 is not destroyed')


        
      })
})
