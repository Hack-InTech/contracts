pragma solidity >=0.8.0;


// Chambre des metiers ou
contract KeyRegistry {

    mapping(bytes32 => address) controllerKeys; // keys to manage authorisation on the registry
    mapping(bytes32 => mapping(bytes32 => bool)) signaturesKey; //did:craftman => BLS12-381 public key => true
    address owner;


    modifier onlyOwner {
        require(msg.sender == owner, "only owner is allowed to perform action");
        _;
    }

    constructor(address owner_) {
        owner = owner_;
    }

    // check if the key is registered onchain
    function validateKey(bytes32 did, bytes32 key) public view returns (bool) {
        return signaturesKey[did][key];
    }

    // add a public key to the registry
    // must be allowed to interact with the did
    function addKey(bytes32 did, bytes32 key) public {
        require( controllerKeys[did] == msg.sender);
        signaturesKey[did][key] = true;
    }

    // authorize an Ethereum key to add BLS key to the registry
    function createId(bytes32 did, address addr) onlyOwner public {
        controllerKeys[did] = addr;
    }
}
