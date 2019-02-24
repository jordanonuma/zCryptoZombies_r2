pragma solidity ^0.4.25;
import "./zombiefactory.sol";

contract KittyInterface {
    function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
    );
} //end contract KittyInterface {}

contract ZombieFeeding is ZombieFactory {
  KittyInterface kittyContract

  function setKittyContractAddress(address _address) external onlyOwner { //onlyOwner modifier from ownable.sol
    kittyContract = KittyInterface(_address);
  } //end setKittyContractAddress()

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) public {
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = zombies[_zombieId]; //permament on blockchain as opposed to in memory

      _targetDna = _targetDna % dnaModulus; //takes last 16 digits of _targetDna
      uint newDna = (myZombie.dna + _targetDna)/2;
      if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
        newDna = newDna - (newDna % 100) + 99;
      } //end if (this is is a zombie kitty))
            _createZombie("NoName", newDna);
  } //end function feedAndMultiply()

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty"); //"kitty" here will set string '_species' in feedAndMultiply()
  } //end function feedOnKitty()
} //end contract ZombieFeeding {}
