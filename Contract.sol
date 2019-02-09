pragma solidity ^0.4.25; //1. Enter solidity version here

//2. Create contract here
contract ZombieFactory {
  event NewZombie(uint zombieId, string name, uint dna);

  uint dnaDigits = 16; //uint must be non-negative and are stored to the blockchain
  uint dnaModulus = 10 ** dnaDigits;

  struct Zombie {
    string name;
    uint dna;
  } //end struct Zombie {}

  Zombie[] public zombies; //public array 'zombies' made up of the 'Zombie' structs

  function _createZombie(string _name, uint _dna) private {
    //adds a new 'Zombie[]' struct to the zombies array
    uint id = zombies.push(Zombie(_name, _dna)) - 1; //array.push() returns array's length [uint]. Subtract 1 for 0 index start
    emit NewZombie(id, _name, _dna);
  } //end function createZombie()

  function generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus; //makes sure integer is only 16 digits long
  } //end function generateRandomDna()

  function createRandomZombie(string _name) public {
    uint randDna = _generateRandomDna(_name);
    _createZombie(_name, randDna);
  } //end function createRandomZombie()
} //end contract ZombieFactory {}
