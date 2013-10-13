package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.baccarat.classic.view.TournamentView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.mediators.AccordionMediator;
	import com.newco.grand.core.common.view.uicomps.PlayersUIView;
	import com.newco.grand.core.common.view.uicomps.WinnersUIView;
	
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	
	public class BaccaratAccordionMediator extends AccordionMediator
	{
		protected var _extended:Boolean=false;
		
		public function BaccaratAccordionMediator()
		{
			super();
		}
		override public function initialize():void {
			super.initialize();
			view.view.y=190;
			view.compHeight= view.compHeight -50;
			signalBus.add(StatisticsEvent.SHOWHIDE,doShowHideEvent);
			/*var statsButton:SMButton=new SMButton(new LastResultAsset());
			
			statsButton.skin.addEventListener(MouseEvent.CLICK,doShowHideStats);
			
			view.view.addChild(statsButton.skin);
			view.display.y=40;
			view.compHeight= view.compHeight -40;*/
		}
		public function doShowHideEvent(signal:BaseSignal):void {
			var show:Boolean=signal.params.extended;
			extended=show;
		}
		public function get extended():Boolean{
			return _extended;
		}
		public function set extended(val:Boolean):void{
			
			if (_extended==false){
				
				Tweener.addTween(view,{x:contextView.view.stage.stageWidth,time:0.5,onComplete:function ():void{}});
			}else{
				Tweener.addTween(view,{x:contextView.view.stage.stageWidth-view.view.width,time:0.5,onComplete:function ():void{}});	
			}
			_extended=val;
		}
		override public function addViews(signal:BaseSignal):void {
			//view.add(new PlayersUIView(), LanguageModel.PLAYERS);
			view.add(new WinnersUIView(), LanguageModel.WINNERLIST);
			//view.add(new BetspotsPanelView(), Language.BACCARAT_BETSPOTSPANEL);
			view.add(new TournamentView(), LanguageModel.TOURNAMENT);
			
			//view.add(new PlayersBetsView(), Language.PLAYERSBETS);
			//view.add(new FavouritesBetsView(), Language.FAVOURITES);
			resize();
		}
	}
}