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
  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d; //CryptoKitties contract address

  KittyInterface kittyContract = KittInterface(ckAddress);

  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = zombies[_zombieId]; //permament on blockchain as opposed to in memory

      _targetDna = _targetDna % dnaModulus; //takes last 16 digits of _targetDna
      uint newDna = (myZombie.dna + _targetDna)/2;
      _createZombie("NoName", newDna);
  } //end function feedAndMultiply()
} //end contract ZombieFeeding {}
