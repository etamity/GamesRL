package com.newco.grand.roulette.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.model.GameState;
	import com.newco.grand.core.common.model.Language;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.roulette.classic.controller.signals.DataGirdEvent;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	import com.newco.grand.roulette.classic.view.FavouritesBetsView;
	
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

			
			//view.applyBtn.textFormat=_textFormat;
			//view.deleteBtn.textFormat=_textFormat;
			//view.clearBtn.textFormat=_textFormat;
			
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