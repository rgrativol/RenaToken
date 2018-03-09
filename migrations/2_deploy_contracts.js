var RenaToken = artifacts.require("./RenaToken.sol");

module.exports = function(deployer) {
  deployer.deploy(RenaToken);
};