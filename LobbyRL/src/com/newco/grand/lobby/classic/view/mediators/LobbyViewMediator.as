package com.newco.grand.lobby.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.TaskbarActionEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	import com.newco.grand.lobby.classic.view.LobbyView;
	
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
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var view:LobbyView;
		
		[Inject]
		public var flashvars:FlashVars;
	
		
		public function LobbyViewMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(LobbyEvents.DATALOADED ,setupModel);
			signalBus.add(BalanceEvent.LOADED ,setBalance);
			signalBus.add(LobbyEvents.SHOW_VIRTUALTABLE ,doShowVirtualTable);
			view.loadHistorySignal.add(doLoadHistory);
			view.loadHelpSignal.add(doLoadHelp);
			
			view.doBackSignal.add(doBackEvent);
			//view.doOpenGameSignal.add(openGameEvent);
		}
		private function doShowVirtualTable(signal:BaseSignal):void{
			view.backBtn.visible=true;
		}
		private function doBackEvent():void{
			signalBus.dispatch(LobbyEvents.SHOW_TABLE);
		}
		
		private function setBalance(signal:BaseSignal):void{
			view.setBalance(player.balanceFormatted);
		}
		private function doLoadHistory():void{
			signalBus.dispatch(TaskbarActionEvent.HISTORY_CLICKED);
		}
		private function doLoadHelp():void{
			signalBus.dispatch(TaskbarActionEvent.HELP_CLICKED);
		}

		private function setupModel(signal:BaseSignal):void{
			player.currencyCode="£";
		
		}

	}
}