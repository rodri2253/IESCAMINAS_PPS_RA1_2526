async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying with:", deployer.address);

  const MerkleChain = await ethers.getContractFactory("MerkleChain");
  const mc = await MerkleChain.deploy();
  await mc.deployed();

  console.log("MerkleChain deployed to:", mc.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
