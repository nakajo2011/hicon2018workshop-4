import lkTestHelpers from 'lk-test-helpers'
const {
  increaseTime,
  shouldFail,
} = lkTestHelpers(web3)

const EducationPass = artifacts.require("EducationPass.sol");
const PassManager = artifacts.require("PassManager.sol");

const callback = (e, r) => new Promise((resolve, reject) => (e ? reject(e) : resolve(r)))

contract('PassManager', function(accounts) {
  describe("init", () => {
    it("should assert true", async () => {
      const manager = await PassManager.new()
      assert.isOk(manager)
    })
    it("create EducationPass", async () => {
      const manager = await PassManager.new()
      await manager.init()
      const tokenAddr = await manager.tokenAddress()
      const educationPass = await EducationPass.at(tokenAddr)
      assert.isOk(educationPass)
    })
  })

  describe('issue', () => {
    let manager, educationPass
    beforeEach(async () => {
      manager = await PassManager.new()
      await manager.init()
      const tokenAddr = await manager.tokenAddress()
      educationPass = await EducationPass.at(tokenAddr)
    })
    it('success', async () => {
      const beforeBalance = await educationPass.balanceOf(accounts[0])
      assert.equal(0, beforeBalance)

      await manager.issue(accounts[0], 12345)
      const afterBalance = await educationPass.balanceOf(accounts[0])
      assert.equal(1, afterBalance)
    })
    it('failed, deplication id.', async () => {
      const beforeBalance = await educationPass.balanceOf(accounts[0])
      assert.equal(0, beforeBalance)

      await manager.issue(accounts[0], 12345)
      await shouldFail.reverting(manager.issue(accounts[1], 12345))
    })
  })
})
