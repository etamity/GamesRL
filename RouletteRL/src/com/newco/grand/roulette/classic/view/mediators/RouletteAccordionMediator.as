package com.newco.grand.roulette.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.mediators.AccordionMediator;
	import com.newco.grand.core.common.view.uicomps.PlayersUIView;
	import com.newco.grand.core.common.view.uicomps.WinnersUIView;
	import com.newco.grand.roulette.classic.view.FavouritesBetsView;
	import com.newco.grand.roulette.classic.view.SideBetSpotsView;
	import com.newco.grand.roulette.classic.view.StatisticsView;
	import com.smart.uicore.controls.events.AccordionEvent;
	
	
	public class RouletteAccordionMediator extends AccordionMediator
	{
		public function RouletteAccordionMediator()
		{
			super();
		}
		override public function addViews(signal:BaseSignal):void {
			
			view.add(new StatisticsView(), LanguageModel.STATISTICS);
			view.add(new PlayersUIView(), LanguageModel.PLAYERS);
			view.add(new WinnersUIView(), LanguageModel.WINNERLIST);
			view.add(new SideBetSpotsView(), LanguageModel.PLAYERSBETS);
			view.add(new FavouritesBetsView(), LanguageModel.FAVOURITES);
			
			view.view.addEventListener(AccordionEvent.SELECTED,doSelected);

			resize();
		}
		private function doSelected(evt:AccordionEvent):void{
			if (evt.label==LanguageModel.PLAYERSBETS)
			{
				signalBus.dispatch(VideoEvent.FULLSCREEN);
			}
		}
	}
}