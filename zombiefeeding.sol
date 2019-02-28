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
  KittyInterface kittyContract;

  function setKittyContractAddress(address _address) external onlyOwner { //onlyOwner modifier from ownable.sol
    kittyContract = KittyInterface(_address);
  } //end setKittyContractAddress()

  function _triggerCooldown(Zombie storage _zombie) internal {
    _zombie.readyTime = uint32(now + cooldownTime); //"coolDownTime = 1 days;" in zombiefactory.sol
  } //end function _triggerCooldown()

  function _isReady(Zombie storage _zombie) internal view returns(bool) {
    return (_zombie.readyTime <= now);
  } //end function _isReady()

  function feedAndMultiply(uint _zombieId, uint _targetDna, string _species) internal {
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = zombies[_zombieId]; //permament on blockchain as opposed to in memory.
                                                    //called in require(_isReady(myZombie)) and _triggerCooldown(myZombie)
      require(_isReady(myZombie)); //checks if cooldown time has passed

      _targetDna = _targetDna % dnaModulus; //takes last 16 digits of _targetDna
      uint newDna = (myZombie.dna + _targetDna)/2;
      if (keccak256(abi.encodePacked(_species)) == keccak256(abi.encodePacked("kitty"))) {
        newDna = newDna - (newDna % 100) + 99;
      } //end if (this is is a zombie kitty))
      _createZombie("NoName", newDna);

      _triggerCooldown(myZombie);
  } //end function feedAndMultiply()

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    feedAndMultiply(_zombieId, kittyDna, "kitty"); //"kitty" here will set string '_species' in feedAndMultiply()
  } //end function feedOnKitty()
} //end contract ZombieFeeding {}
