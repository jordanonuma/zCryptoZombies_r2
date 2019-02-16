pragma solidity ^0.4.25;
import "./zombiefactory.sol";

contract ZombieFeeding is ZombieFactory {
  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
      require(msg.sender == zombieToOwner[_zombieId]);
      Zombie storage myZombie = zombies[_zombieId]; //permament on blockchain as opposed to in memory

      _targetDna = _targetDna % dnaModulus; //takes last 16 digits of _targetDna
      uint newDna = (myZombie.dna + _targetDna)/2;
      _createZombie("NoName", newDna);
  } //end function feedAndMultiply()
} //end contract ZombieFeeding {}
