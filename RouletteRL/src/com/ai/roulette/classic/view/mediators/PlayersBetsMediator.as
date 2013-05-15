package com.ai.roulette.classic.view.mediators
{
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.roulette.classic.controller.signals.DataGirdEvent;
	import com.ai.roulette.classic.model.GameDataModel;
	import com.ai.roulette.classic.view.PlayersBetsView;
	
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