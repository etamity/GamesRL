package com.newco.grand.roulette.classic.view.mediators
{
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.BetEvent;
	import com.ai.core.common.controller.signals.ModelReadyEvent;
	import com.ai.core.common.controller.signals.TaskbarActionEvent;
	import com.ai.core.common.controller.signals.UIEvent;
	import com.ai.core.common.model.SignalBus;
	import com.newco.grand.roulette.classic.view.LobbyView;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class LobbyMediator extends BaseMediator
	{
		[Inject]
		public var view:LobbyView;
		
		private var subLobby:MovieClip;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function LobbyMediator()
		{
			super();
		}
		
		override public function initialize():void {
			/*eventMap.mapListener( eventDispatcher, UIEvent.LOBBY_LOADED, lobbyLoaded);
			eventMap.mapListener( eventDispatcher, TaskbarActionEvent.LOBBY_CLICKED, launchLobby);
			eventMap.mapListener(eventDispatcher, UIEvent.HELP_LOADED, setHelp);*/
			
			signalBus.dispatch(UIEvent.LOBBY_LOADED, lobbyLoaded);
			signalBus.dispatch(TaskbarActionEvent.LOBBY_CLICKED, launchLobby);
			signalBus.dispatch(UIEvent.HELP_LOADED, setHelp);
		}
		
		private function launchLobby(signal:BaseSignal):void {
			view.visible = true;
			debug('loading lobby..');
		}
		
		private function lobbyLoaded(signal:BaseSignal):void {
			var subLobby:MovieClip = signal.params.movieclip as MovieClip;
			view.lobby = subLobby;
			/*if(subLobby.hasOwnProperty("loadLobbyXML") ) {
				subLobby.loadLobbyXML();
			}
			subLobby.addEventListener("SubLobbyLoaded", setupGameType);*/
		}
		
		private function setupGameType(event:Event):void {
			subLobby.game = "roulette";
		}
		
		
		private function setHelp(signal:BaseSignal):void {
			/*var help:MovieClip = evt.data as MovieClip;
			view.addChild(help);
			help.init(true);
			help.visible = true;
			help.loadHelp("lobby", "help");
			help.x = 0;
			help.y = 0;
			view.visible = true;*/
		}
		
	}
}