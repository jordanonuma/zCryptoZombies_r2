pragma solidity ^0.4.25;
import "./ERC721XToken.sol";

contract ZombieCard is ERC721XToken {

  function name() external view returns (string) {
      return "ZombieCard";
  } //end function name()
} //end contract {}
