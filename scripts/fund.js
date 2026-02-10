const hre = require('hardhat');

async function main() {
  const contractAddress = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
  
  const [signer] = await hre.ethers.getSigners();
  
  const amount = hre.ethers.parseEther('10');
  
  console.log(`Funding contract ${contractAddress} with 10 ETH...`);
  
  const tx = await signer.sendTransaction({
    to: contractAddress,
    value: amount,
  });
  
  await tx.wait();
  console.log(`Successfully funded with 10 ETH`);
  console.log(`Transaction hash: ${tx.hash}`);
}

main();
