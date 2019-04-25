pragma solidity ^0.4.25;
import "./ERC721XToken.sol";
import "./Ownable.sol";

contract ZombieCard is ERC721XToken {

mapping (uint => uint) internal tokenIdToIndividualSupply;
mapping (uint => uint) internal nftTokenIDToMouldId;
uint nftTokenIdIndex = 1000000;
event TokenAwarded(uint indexed tokenId, address claimer, uint amount);

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
    tokenIdToIndividualSupply[_tokenId] = _supply;
  } //end function mintToken()

  function awardToken(uint _tokenId, address _to, uint _amount) public onlyOwner {
    require(exists(_tokenId), "TokenID has not been minted");
    if (individualSupply[_tokenId] > 0) {
        require(_amount <= balanceOf(msg.sender, _tokenId), "Quantity greater than remaining cards");
        _updateTokenBalance(msg.sender, _tokenId, _amount, ObjectLib.Operations.SUB);
    } //end if(token is NFT)
    _updateTokenBalance(_to, _tokenId, _amount, ObjectLib.Operations.ADD);
    emit TokenAwarded(_tokenId, _to, _amount);
  } //end function awardToken()

  function convertToNFT(uint _tokenId, uint _amount) public {
    require(tokenType[_tokenId] == FT);
    require(_amount <= balanceOf(msg.sender, _tokenId), "You do not own enough tokens");
    _updateTokenBalance(msg.sender, _tokenId, _amount, ObjectLib.Operations.SUB);
    for (uint i = 0; i < _amount ; i++) {
      _mint(nftTokenIdIndex, msg.sender);
      nftTokenIdToMouldId[nftTokenIdIndex] = _tokenId;
      nftTokenIdIndex++;
    } //end for()
  } //end function convertToNFT()

  function convertToFT(uint _tokenId) public {
    require(tokenType[_tokenId] == NFT);
    require(ownerOf(_tokenId) == msg.sender, "You do not own this token");
    _updateTokenBalance(msg.sender, _tokenId, 0, ObjectLib.Operations.REPLACE);
    _updateTokenBalance(msg.sender, nftTokenIdToMouldId[_tokenId], 1, ObjectLib.Operations.ADD);
    emit TransferWithQuantity(address(this), msg.sender, nftTokenIdToMouldId[_tokenId], 1);
  } //end function convertToFT()
} //end contract {}
