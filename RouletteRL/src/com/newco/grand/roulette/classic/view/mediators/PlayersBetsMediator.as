package com.newco.grand.roulette.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	import com.newco.grand.roulette.classic.view.PlayersBetsView;
	
	import fl.data.DataProvider;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class PlayersBetsMediator extends Mediator{
		[Inject]
		public var view:PlayersBetsView;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function PlayersBetsMediator()
		{
			
		}
		
		override public function initialize():void {
			/*eventMap.mapListener(eventDispatcher, ModelReadyEvent.READY, setupModel);
			eventMap.mapListener(eventDispatcher, BetEvent.FAVOURITES, addFaouritesBets);
			view.addEventListener(DataGirdEvent.CHANGE,loadPlayersBets);*/
			signalBus.add(ModelReadyEvent.READY, setupModel);
			signalBus.add(BetEvent.FAVOURITES, addFaouritesBets);
			view.dataChangeSignal.add(loadPlayersBets);
		}
		private function loadPlayersBets(item:Object):void{
			var betString:String=item.betString;
			view.loadBetsString(betString);
		}
		private function addFaouritesBets(signal:BaseSignal):void{
			player.addFaouritesBets(view.colum1,view.colum2);
			view.dataGrid.dataProvider= new DataProvider(player.savedBets);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
		}
		
	}
}