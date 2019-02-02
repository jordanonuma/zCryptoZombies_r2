pragma solidity ^0.4.25; //1. Enter solidity version here

//2. Create contract here
contract ZombieFactory {
  uint dnaDigits = 16; //uint must be non-negative and are stored to the blockchain
  uint dnaModulus = 10 ** dnaDigits;

  struct Zombie {
    string name;
    uint dna;
  } //end struct Zombie {}

  Zombie[] public zombies; //public array 'zombies' made up of the 'Zombie' structs
} //end contract ZombieFactory {}
