package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.baccarat.classic.view.BetspotsPanelView;
	import com.newco.grand.baccarat.classic.view.TournamentView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.Language;
	import com.newco.grand.core.common.view.mediators.AccordionMediator;
	import com.newco.grand.core.common.view.uicomps.PlayersUIView;
	import com.newco.grand.core.common.view.uicomps.WinnersUIView;
	
	import flash.events.MouseEvent;
	
	public class BaccaratAccordionMediator extends AccordionMediator
	{
		public function BaccaratAccordionMediator()
		{
			super();
		}
		override public function initialize():void {
			super.initialize();
			var shoeStatsMc:ShoeStatsAsset =new ShoeStatsAsset();
			//shoeStatsMc.x= view.display.stage.stageWidth - shoeStatsMc.width;
			
			view.view.addChild(shoeStatsMc);
			view.display.y=130;
			view.compHeight= view.compHeight -50;
			
			/*var statsButton:SMButton=new SMButton(new LastResultAsset());
			
			statsButton.skin.addEventListener(MouseEvent.CLICK,doShowHideStats);
			
			view.view.addChild(statsButton.skin);
			view.display.y=40;
			view.compHeight= view.compHeight -40;*/
		}
		private function doShowHideStats(evt:MouseEvent):void{
			signalBus.dispatch(StatisticsEvent.SHOWHIDE);
		}
		override public function addViews(signal:BaseSignal):void {
			view.add(new PlayersUIView(), Language.PLAYERS);
			view.add(new WinnersUIView(), Language.WINNERLIST);
			view.add(new BetspotsPanelView(), Language.BACCARAT_BETSPOTSPANEL);
			view.add(new TournamentView(), Language.TOURNAMENT);
			
			//view.add(new PlayersBetsView(), Language.PLAYERSBETS);
			//view.add(new FavouritesBetsView(), Language.FAVOURITES);
			resize();
		}
	}
}