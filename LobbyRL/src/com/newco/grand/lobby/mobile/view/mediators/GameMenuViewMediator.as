package com.newco.grand.lobby.mobile.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.mobile.view.GameMenuView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class GameMenuViewMediator extends Mediator
	{
		[Inject]
		public var view:GameMenuView;
		[Inject]
		public var signalBus:SignalBus;
		public function GameMenuViewMediator()
		{
			super();
		}
		override public function initialize():void
		{
	
			signalBus.add(LobbyEvents.LOBBYDATA_LOADED,setModelData);
		}
		private function setModelData(signal:BaseSignal):void{
			view.visible=true;
			view.gameSingal.add(showLobby);
		}
		private function showLobby(game:String):void{
			signalBus.dispatch(LobbyEvents.SHOW_TABLE,{game:game});
		}
	}
}