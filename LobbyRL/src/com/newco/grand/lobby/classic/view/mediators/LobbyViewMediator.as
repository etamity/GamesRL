package com.newco.grand.lobby.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class LobbyViewMediator extends Mediator
	{
		[Inject]
		public var contextView:ContextView;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var lobbyModel:LobbyModel;
		
		public function LobbyViewMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(LobbyEvents.DATALOADED ,setupModel)
		}
		private function setupModel(signal:BaseSignal):void{
			
		}
	}
}