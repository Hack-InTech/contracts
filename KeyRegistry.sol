pragma solidity >=0.8.0;

contract RevocationList {

    mapping(bytes32 => bool) revocationList;

    function revocateDocument(bytes32 didPreuve) public {
        revocationList[keccak256(abi.encodePacked(msg.sender, didPreuve))] = true;
    }

    function isDocumentRevocated(bytes32 didPreuve, address controller) public view returns (bool){
        return revocationList[keccak256(abi.encodePacked(controller, didPreuve))];
    }
}
