package com.newco.grand.baccarat.classic.service {
	
	import com.newco.grand.baccarat.classic.controller.signals.BaccaratEvent;
	import com.newco.grand.baccarat.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.baccarat.classic.controller.signals.WinnersEvent;
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.PlayersEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.GameState;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.service.SocketService;
	
	import flash.events.DataEvent;
	
	public class GameSocketService extends SocketService {
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function GameSocketService() {			
			
		}
		
		override protected function dataHandler(event:DataEvent):void {

			var node:XML = new XML(event.data);
			var type:String = node.name().localName;
			debug("[SOCKET DATA] : "+ event.data);
			switch(type) {
				case Constants.SOCKET_SUBSCRIBE:
					//<subscribe channel="session-83p1hpolg39cptwc" status="success" />			
					if (node.@channel == "session-" + flashVars.user_id + "" && node.@status == "success") {
						subscribeToChannel();
						//dispatch(new SocketDataEvent(SocketDataEvent.INITIALIZE, node));
						signalBus.dispatch(SocketDataEvent.INITIALIZE,{node:node});
					}
					break;
				
				case Constants.SOCKET_DEALER:
					game.dealer = node;
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_DEALER, node));
					signalBus.dispatch(SocketDataEvent.HANDLE_DEALER,{node:node});
					break;
				
				case Constants.SOCKET_TABLE:
					game.table = node;
					break;
				
				case Constants.SOCKET_GAME:
					player.bet = 0;
					player.winnings = 0;
					game.gameTime = node;
					game.gameID = node.@id;
					GameState.state = (node.@id != "") ? GameState.WAITING_FOR_BETS : GameState.NO_GAME;
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_GAME, node));
					signalBus.dispatch(SocketDataEvent.HANDLE_GAME,{node:node});
					refreshEvents();
					break;
				
				case Constants.SOCKET_SEAT:
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_SEAT, node));
					signalBus.dispatch(SocketDataEvent.HANDLE_SEAT,{node:node});
					break;
				
				case Constants.SOCKET_BET:
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_BET, node));
					signalBus.dispatch(SocketDataEvent.HANDLE_BET,{node:node});
					break;
				
				case Constants.SOCKET_GAME_CANCELED:					
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_CANCEL, node));
					player.bet = 0;
					signalBus.dispatch(SocketDataEvent.HANDLE_CANCEL,{node:node});
					break;
				
				case Constants.SOCKET_GAME_STATE:
					switch (node){
						case Constants.BETS_CLOSED:
							//eventDispatcher.dispatchEvent(new BetEvent(BetEvent.CLOSE_BETS));
							signalBus.dispatch(BetEvent.CLOSE_BETS,{node:node});
							break;
					}
					
				
					break;
				
				case Constants.SOCKET_TIMER:
					game.countdown = Number(node);
					if(game.countdown > 0) {
						GameState.state = GameState.WAITING_FOR_BETS;
						//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_TIMER, node));
						signalBus.dispatch(SocketDataEvent.HANDLE_TIMER,{node:node});
					}
					else {
						GameState.state = GameState.WAITING_FOR_RESULT;
					}					
					break;
				
				case Constants.SOCKET_GAME_RESULT:
					game.resultXML = node;
					game.statusMessage  = node +" " +LanguageModel.WIN ;
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_RESULT, node));
					signalBus.dispatch(SocketDataEvent.HANDLE_RESULT,{node:node});
					break;
				
				case Constants.SOCKET_GAME_CANCELED:
					GameState.state = GameState.CANCELLED;
					break;
				
				case Constants.SOCKET_WHEEL_ERROR:
					break;
				
				case Constants.SOCKET_SCORDCARD:
					if (node.children().length() > 0) 
						signalBus.dispatch(BaccaratEvent.SCORDCARD,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.SCORDCARD , node));
					break;
				case Constants.SOCKET_COMMAND:
					if (node.hasOwnProperty("broadcastBet")) {
						signalBus.dispatch(BaccaratEvent.COMMAND,{node:node});
						//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.COMMAND , node));
					}
					break;
				case Constants.SOCKET_KICKOUT:
					signalBus.dispatch(BaccaratEvent.KICKOUT,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.KICKOUT , node));
					break;
				case Constants.SOCKET_PAIRRESULT:
					signalBus.dispatch(BaccaratEvent.PAIRRESULT,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.PAIRRESULT , node));
					break;
				case Constants.SOCKET_INSURANCETIMER:
					signalBus.dispatch(BaccaratEvent.INSURANCETIMER,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.INSURANCETIMER , node));
					break;
				case Constants.SOCKET_INSURANCE:
					signalBus.dispatch(BaccaratEvent.INSURANCE,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.INSURANCE , node));
					break;
				case Constants.SOCKET_CARDMOVE:
					signalBus.dispatch(BaccaratEvent.CARDMOVE,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.CARDMOVE , node));
					break;
				case Constants.SOCKET_DECISION:
					signalBus.dispatch(BaccaratEvent.DECISION,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.DECISION , node));
					break;
				case Constants.SOCKET_DECISIONINC:
					signalBus.dispatch(BaccaratEvent.DECISIONINC,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.DECISIONINC , node));
					break;
				case Constants.SOCKET_CARDINC:
					signalBus.dispatch(BaccaratEvent.CARDINC,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.CARDINC , node));
					break;
				case Constants.SOCKET_CARD:
					signalBus.dispatch(BaccaratEvent.CARD,{node:node});
					//eventDispatcher.dispatchEvent(new BaccaratEvent(BaccaratEvent.CARD , node));
					break;
				
			}					
			game.response = type;
		}
		
		private function refreshEvents():void {
			/*eventDispatcher.dispatchEvent(new BalanceEvent(BalanceEvent.LOAD));
			eventDispatcher.dispatchEvent(new PlayersEvent(PlayersEvent.LOAD));
			eventDispatcher.dispatchEvent(new WinnersEvent(WinnersEvent.LOAD));
			eventDispatcher.dispatchEvent(new StatisticsEvent(StatisticsEvent.LOAD));
			eventDispatcher.dispatchEvent(new BetEvent(BetEvent.TOTAL_BET));*/
			
			signalBus.dispatch(BalanceEvent.LOAD);
			signalBus.dispatch(PlayersEvent.LOAD);
			signalBus.dispatch(WinnersEvent.LOAD);
			signalBus.dispatch(StatisticsEvent.LOAD);
			signalBus.dispatch(BetEvent.TOTAL_BET);
		}
	}
}