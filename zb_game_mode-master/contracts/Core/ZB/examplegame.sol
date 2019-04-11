pragma solidity 0.4.25;
import "./ZB/ZBGameMode.sol";

contract ExampleGame is ZBGameMode  {

  mapping (string => bool) internal bannedCards;

  function beforeMatchStart(bytes serializedGameState) external {
    GameState memory gameState;
    gameState.init(serializedGameState);

    ZBSerializer.SerializedGameStateChanges memory changes; //declares custom data type that tracks all changes made to game state
    changes.init();

    //Sets the defense and initial available, filled, and max vials for both players
    changes.changePlayerDefense(Player.Player1, 15);
    changes.changePlayerDefense(Player.Player2, 15);
    changes.changePlayerCurrentGooVials(Player.Player1, 3);
    changes.changePlayerCurrentGooVials(Player.Player2, 3);
    changes.changePlayerCurrentGoo(Player.Player1, 3);
    changes.changePlayerCurrentGoo(Player.Player2, 3);
    changes.changePlayerMaxGooVials(Player.Player1, 8);
    changes.changePlayerMaxGooVials(Player.Player2, 8);
  } //end function beforeMatchStart()

} //end contract ExampleGame{}
