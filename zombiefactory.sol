pragma solidity ^0.4.25; //1. Enter solidity version here
import "./ownable.sol";
import "./safemath.sol";

//2. Create contract here
contract ZombieFactory is Ownable {
  using SafeMath for uint256;
  using SafeMath for uint32;
  using SafeMath for uint16;
  event NewZombie(uint zombieId, string name, uint dna);

  uint dnaDigits = 16; //uint must be non-negative and are stored to the blockchain
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;

  struct Zombie {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  } //end struct Zombie {}

  Zombie[] public zombies; //public array 'zombies' made up of the 'Zombie' structs

  mapping (uint => address) public zombieToOwner;
  mapping (address => uint) ownerZombieCount;

  function _createZombie(string _name, uint _dna) internal {
    //adds a new 'Zombie[]' struct to the zombies array
    uint id = zombies.push(Zombie(_name, _dna, 1, uint32(now + cooldownTime), 0, 0)) - 1; //array.push() returns array's length [uint]. Subtract 1 for 0 index start
    zombieToOwner[id] = msg.sender;
    ownerZombieCount[msg.sender] = ownerZombieCount[msg.sender].add(1);
    emit NewZombie(id, _name, _dna);
  } //end function createZombie()

  function generateRandomDna(string _str) private view returns (uint) {
    uint rand = uint(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus; //makes sure integer is only 16 digits long
  } //end function generateRandomDna()

  function createRandomZombie(string _name) public {
    require(ownerZombieCount[msg.sender] == 0);
    uint randDna = _generateRandomDna(_name);
    _createZombie(_name, randDna);
  } //end function createRandomZombie()
} //end contract ZombieFactory {}
