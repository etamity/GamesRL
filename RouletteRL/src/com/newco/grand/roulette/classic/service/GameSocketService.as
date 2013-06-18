package com.newco.grand.roulette.classic.service {
	
	import com.ai.core.common.controller.signals.BalanceEvent;
	import com.ai.core.common.controller.signals.BetEvent;
	import com.ai.core.common.controller.signals.PlayersEvent;
	import com.ai.core.common.controller.signals.SocketDataEvent;
	import com.ai.core.common.controller.signals.WinnersEvent;
	import com.ai.core.common.model.Constants;
	import com.ai.core.common.model.GameState;
	import com.ai.core.common.model.Language;
	import com.ai.core.common.model.Player;
	import com.ai.core.common.model.SignalBus;
	import com.ai.core.common.service.SocketService;
	import com.newco.grand.roulette.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	
	import flash.events.DataEvent;
	
	public class GameSocketService extends SocketService {
		
		[Inject]
		public var game:GameDataModel;
		
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
					GameState.state = GameState.PLACING_BETS;
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_BET, node));
					signalBus.dispatch(SocketDataEvent.HANDLE_BET,{node:node});
					break;
				
				case Constants.SOCKET_GAME_CANCELED:					
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_CANCEL, node));
					GameState.state = GameState.CANCELLED;
					player.bet = 0;
					signalBus.dispatch(SocketDataEvent.HANDLE_CANCEL,{node:node});
					break;
				
				case Constants.SOCKET_GAME_STATE:
					GameState.state = GameState.BETS_CLOSED;
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
					game.result=Number(String(node).split(" ")[0]); 
					game.statusMessage  = node +" " +Language.WIN ;
					//dispatch(new SocketDataEvent(SocketDataEvent.HANDLE_RESULT, node));
					signalBus.dispatch(SocketDataEvent.HANDLE_RESULT,{node:node});
					break;
				
				case Constants.SOCKET_GAME_CANCELED:
					GameState.state = GameState.CANCELLED;
					break;
				
				case Constants.SOCKET_WHEEL_ERROR:
					break;
			}					
			game.response = type;
		}
		
		private function refreshEvents():void {
			signalBus.dispatch(BalanceEvent.LOAD);
			signalBus.dispatch(PlayersEvent.LOAD);
			signalBus.dispatch(WinnersEvent.LOAD);
			signalBus.dispatch(StatisticsEvent.LOAD);
			signalBus.dispatch(BetEvent.TOTAL_BET);
		}
	}
}