const hre = require('hardhat');

async function main() {
  const V = await hre.ethers.getContractFactory('TokenVesting');
  const v = await V.deploy(
    '0x000000000000000000000000000000000000dEaD',
    Math.floor(Date.now() / 1000),
    3600,
  );
  await v.waitForDeployment();
  console.log('Deployed:', await v.getAddress());
}

main();
