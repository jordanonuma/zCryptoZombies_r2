pragma solidity 0.4.25;
import "./ZB/ZBGameMode.sol";

contract ExampleGame is ZBGameMode  {

  function beforeMatchStart(bytes serializedGameState) external {
    GameState memory gameState;
    gameState.init(serializedGameState);

    ZBSerializer.SerializedGameStateChanges memory changes; //declares custom data type that tracks all changes made to game state
    changes.init(); 
  } //end function beforeMatchStart()

} //end contract ExampleGame{}
