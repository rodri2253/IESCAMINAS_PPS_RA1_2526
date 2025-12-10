const { expect } = require("chai");
const { ethers } = require("hardhat");

// Helper para hashear texto -> leaf hash
const leafHash = (text) => ethers.utils.keccak256(ethers.utils.toUtf8Bytes(text));

// Helper para hash de par ordenado siguiendo la misma convención (menor||mayor)
const pairHash = (a, b) => {
  if (a < b) {
    return ethers.utils.keccak256(ethers.utils.concat([a, b]));
  } else {
    return ethers.utils.keccak256(ethers.utils.concat([b, a]));
  }
};

describe("MerkleChain (basic)", function () {
  it("initialize y verifyInBlock con prueba simple", async function () {
    const [owner] = await ethers.getSigners();
    const MerkleChain = await ethers.getContractFactory("MerkleChain");
    const mc = await MerkleChain.deploy();
    await mc.deployed();

    // Construcción de un árbol sencillo de 4 hojas: A,B,C,D
    const A = leafHash("A");
    const B = leafHash("B");
    const C = leafHash("C");
    const D = leafHash("D");

    // Nivel 1: pares
    const AB = pairHash(A, B);
    const CD = pairHash(C, D);

    // Raíz
    const ROOT = pairHash(AB, CD);

    // Inicializar contrato con ROOT
    await mc.initialize(ROOT);
    expect(await mc.length()).to.equal(1);

    // Construir prueba para la hoja "A"
    // Camino A -> AB -> ROOT; proof = [B, CD] (siblings encountered from leaf up)
    const proofForA = [B, CD];

    const ok = await mc.verifyInBlock(A, proofForA, 0);
    expect(ok).to.equal(true);
  });
});
