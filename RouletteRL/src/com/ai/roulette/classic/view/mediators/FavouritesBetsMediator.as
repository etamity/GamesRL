package com.ai.roulette.classic.view.mediators
{
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.SocketDataEvent;
	import com.ai.core.model.GameState;
	import com.ai.core.model.Language;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.roulette.classic.controller.signals.DataGirdEvent;
	import com.ai.roulette.classic.model.GameDataModel;
	import com.ai.roulette.classic.view.FavouritesBetsView;
	
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import fl.data.DataProvider;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class FavouritesBetsMediator extends Mediator {
		[Inject]
		public var view:FavouritesBetsView;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var game:GameDataModel;
		
		[Inject]
		public var signalBus:SignalBus;
		
		public function FavouritesBetsMediator()
		{
			
		}
		private function setupModel(signal:BaseSignal):void {
			view.init();
			var _textFormat:TextFormat = new TextFormat("Arial", 10, 0x998F7A, true);

			
			view.applyBtn.textFormat=_textFormat;
			view.deleteBtn.textFormat=_textFormat;
			view.clearBtn.textFormat=_textFormat;
			
			view.applyBtn.skin.addEventListener(MouseEvent.CLICK,doApplyAction);
			view.clearBtn.skin.addEventListener(MouseEvent.CLICK,doClearAction);
			view.deleteBtn.skin.addEventListener(MouseEvent.CLICK,doDeleteAction);
			
			view.applyBtn.label= Language.APPLYBUTTON;
			view.clearBtn.label= Language.CLEARBUTTON;
			view.deleteBtn.label= Language.DELETEBUTTON;
			signalBus.add(BetEvent.FAVOURITES, addFaouritesBets);
			signalBus.add(BetEvent.CLOSE_BETS, closeBetting);
			signalBus.add(SocketDataEvent.HANDLE_TIMER, checkBettingState);
		}
		override public function initialize():void {
			
			signalBus.add(ModelReadyEvent.READY, setupModel);
	
			//view.addEventListener(DataGirdEvent.CHANGE,loadPlayersBets);
			view.dataChangeSignal.add(loadPlayersBets);
			
		}
		private function checkBettingState(signal:BaseSignal = null):void {
			if(GameState.state == GameState.WAITING_FOR_BETS) {
				if (view.playersListDgMc.selectedIndex>=0)
					view.enabledButtons(true);
			}
		}
		
		private function closeBetting(signal:BaseSignal):void {
			view.enabledButtons(false);
		}
		private function doApplyAction(evt:MouseEvent):void{
			//eventDispatcher.dispatchEvent(new DataGirdEvent(DataGirdEvent.FAVOURITESAPPLY,view.playersListDgMc.selectedItem));
			signalBus.dispatch(DataGirdEvent.FAVOURITESAPPLY,view.playersListDgMc.selectedItem);
		}
		private function doClearAction(evt:MouseEvent):void{
			view.playersListDgMc.removeAll();
		}
		private function doDeleteAction(evt:MouseEvent):void{
			view.playersListDgMc.removeItem(view.playersListDgMc.selectedItem);
		}
		private function loadPlayersBets(item:Object):void{
			var betString:String=item.betString;
			view.loadBetsString(betString);
		}
		private function addFaouritesBets(signal:BaseSignal):void{
			player.addFaouritesBets(view.colum1,view.colum2);
			view.dataGrid.dataProvider= new DataProvider(player.savedBets);
		}
		

		
	}
}