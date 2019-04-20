pragma solidity ^0.4.25;
import "./ERC721XToken.sol";
import "./Ownable.sol";

contract ZombieCard is ERC721XToken {

mapping (uint => uint) internal tokenIdToIndividualSupply;

  function name() external view returns (string) {
      return "ZombieCard";
  } //end function name()

  function symbol() external view returns (string) {
    return "ZCX";
  } //end function symbol()

  function individualSupply(uint _tokenId) public view returns (uint) {
    return tokenIdToIndividualSupply[_tokenId];
  } //end function individualSupply()

  function mintToken(uint _tokenId, uint _supply) public onlyOwner {
    require(!exists(_tokenId), "Error: Tried to mint duplicate token id");
    _mint(_tokenId, msg.sender, _supply);
  } //end function mintToken()
} //end contract {}
