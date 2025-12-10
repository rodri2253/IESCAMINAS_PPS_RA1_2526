// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title MerkleChain
/// @author TuNombre
/// @notice Contrato privado (owner-only) que inicia una "cadena" de raíces Merkle,
///         permite añadir nuevas raíces y verificar pruebas de inclusión.
/// @dev Las pruebas Merkle deben seguir la misma convención de orden que `verifyProof`.
contract MerkleChain {
    address public owner;

    struct BlockEntry {
        bytes32 root;      // raíz de Merkle del bloque
        bytes32 prevRoot;  // raíz anterior (0x0 para el primero)
        uint256 timestamp; // marca temporal de inserción
        uint256 index;     // índice en la cadena (0-based)
    }

    mapping(uint256 => BlockEntry) private chain;
    uint256 public length; // número de bloques almacenados

    event Initialized(bytes32 indexed root, address indexed by, uint256 index);
    event Appended(bytes32 indexed newRoot, bytes32 indexed prevRoot, address indexed by, uint256 index);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "MerkleChain: solo owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        length = 0;
    }

    /// @notice Inicializa la cadena con una raíz (sólo una vez).
    /// @param root La raíz de Merkle del primer bloque.
    function initialize(bytes32 root) external onlyOwner {
        require(length == 0, "MerkleChain: ya inicializado");
        require(root != bytes32(0), "MerkleChain: root invalida");
        chain[0] = BlockEntry({
            root: root,
            prevRoot: bytes32(0),
            timestamp: block.timestamp,
            index: 0
        });
        length = 1;
        emit Initialized(root, msg.sender, 0);
    }

    /// @notice Añade una nueva raíz a la cadena (owner only).
    /// @param newRoot La nueva raíz de Merkle.
    function append(bytes32 newRoot) external onlyOwner {
        require(newRoot != bytes32(0), "MerkleChain: root invalida");
        bytes32 prev = length == 0 ? bytes32(0) : chain[length - 1].root;
        chain[length] = BlockEntry({
            root: newRoot,
            prevRoot: prev,
            timestamp: block.timestamp,
            index: length
        });
        emit Appended(newRoot, prev, msg.sender, length);
        length++;
    }

    /// @notice Devuelve la entrada en un índice dado (view).
    /// @param idx Índice del bloque.
    function getEntry(uint256 idx) external view returns (bytes32 root, bytes32 prevRoot, uint256 timestamp, uint256 index) {
        require(idx < length, "MerkleChain: indice fuera de rango");
        BlockEntry storage e = chain[idx];
        return (e.root, e.prevRoot, e.timestamp, e.index);
    }

    /// @notice Devuelve la última raíz (si existe).
    function getLastRoot() external view returns (bytes32) {
        require(length > 0, "MerkleChain: vacio");
        return chain[length - 1].root;
    }

    /// @notice Verifica una prueba Merkle contra una raíz dada.
    /// @dev La convención de orden: se concatena menor||mayor (determinista) antes de keccak256.
    /// @param leaf El hash de la hoja (por convención, la hoja debe estar ya hasheada).
    /// @param proof Array de hashes (siblings) desde la hoja hacia la raíz.
    /// @param root La raíz contra la que verificar.
    /// @return true si la prueba es válida.
    function verifyProof(bytes32 leaf, bytes32[] memory proof, bytes32 root) public pure returns (bool) {
        bytes32 computed = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];
            if (computed < proofElement) {
                computed = keccak256(abi.encodePacked(computed, proofElement));
            } else {
                computed = keccak256(abi.encodePacked(proofElement, computed));
            }
        }
        return computed == root;
    }

    /// @notice Verifica inclusión de una hoja en un bloque concreto por su índice.
    /// @param leaf El hash de la hoja.
    /// @param proof La prueba (siblings).
    /// @param blockIndex Índice del bloque cuya raíz se toma.
    function verifyInBlock(bytes32 leaf, bytes32[] memory proof, uint256 blockIndex) external view returns (bool) {
        require(blockIndex < length, "MerkleChain: indice fuera de rango");
        bytes32 root = chain[blockIndex].root;
        return verifyProof(leaf, proof, root);
    }

    /// @notice Transfiere la propiedad del contrato.
    /// @param newOwner Dirección del nuevo owner.
    function transferOwnership(address newOwner) external onlyOwner {
        require(newOwner != address(0), "MerkleChain: owner nulo");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
