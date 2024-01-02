const {loadFixture} = require('@nomicfoundation/hardhat-network-helpers');
const {expect} = require('chai');
const {ethers} = require('hardhat');

describe('ERC20',async function(){

    const initialSupply = 2000;
    const tokenName = 'Gtoken';
    const tokenSymbol = 'GTK';
    let token;
    let owner,user1,user2,user3;

    before(async function(){
     const Token = await ethers.getContractFactory('ERC20');
      token = await Token.deploy(tokenName,tokenSymbol,initialSupply);
      const [owner1,owner2,owner3,owner4] = await ethers.getSigners();
      owner = owner1.address;
      user1=owner2.address;
      user2=owner3.address;
      user3=owner4.address;
    });
   

   it('it should deploy contract and set the owner correctly',async ()=>{
     expect(await token.owner()).to.equal(owner);
   });

   it('Token name should the same as the tokenName variable',async()=>{
      expect(await token.name()).to.equal(tokenName);
   });

   it('Token symbol should be the same as the symbol varible',async()=>{
      expect(await token.symbol()).to.equal(tokenSymbol);
   });

   it('Token decimal should be equal to 18',async()=>{
      expect(await token.decimals()).to.equal(18);
   });

   it('Get owner account balance and it should be more then zero', async()=>{
      expect(await token.balanceOf(owner)).to.be.gt(0);
   });

   it('transfer a token from owners account to a user account',async()=>{
      const ownerBalance = BigInt(await token.balanceOf(owner));
      const amountToSend = BigInt(100);
      await token.transfer(user1,amountToSend);
      expect(await token.balanceOf(user1)).to.equal(amountToSend);
      expect(await token.balanceOf(owner)).to.equal(ownerBalance - amountToSend);
   });

   it('should approve an account to spend on your behave',async()=>{
      const amountToSpend = 10;
      await token.approve(user2,amountToSpend);
      expect(await token.allowance(owner,user2)).to.equal(amountToSpend);
   });

});