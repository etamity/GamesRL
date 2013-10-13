package com.newco.grand.lobby.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.view.HistoryView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class HistoryViewMediator extends Mediator
	{
		[Inject]
		public var contextView:ContextView;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var player:Player;
		[Inject]
		public var view:HistoryView;
		public function HistoryViewMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(LobbyEvents.LOBBYDATA_LOADED ,setupModel);
		}
		private function setupModel(signal:BaseSignal):void{
			signalBus.add(LobbyEvents.ACCOUNTHISTORY_LOADED,doAccountHistory);
			signalBus.add(LobbyEvents.ACTIVITYHISTORY_LOADED,doActivityHistory);
			view.init();
		}
		private function doAccountHistory(signal:BaseSignal):void{
			var xml:XML=signal.params.xml;
			view.setAccountData(xml);
		}
		private function doActivityHistory(signal:BaseSignal):void{
			var xml:XML=signal.params.xml;
			view.setActivityData(xml);
		}
	}
}