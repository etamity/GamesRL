package com.newco.grand.roulette.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.Language;
	import com.newco.grand.core.common.view.mediators.AccordionMediator;
	import com.newco.grand.core.common.view.uicomps.PlayersUIView;
	import com.newco.grand.core.common.view.uicomps.WinnersUIView;
	import com.newco.grand.roulette.classic.view.FavouritesBetsView;
	import com.newco.grand.roulette.classic.view.SideBetSpotsView;
	import com.newco.grand.roulette.classic.view.StatisticsView;
	import com.smart.uicore.controls.events.AccordionEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	
	
	public class RouletteAccordionMediator extends AccordionMediator
	{
		public function RouletteAccordionMediator()
		{
			super();
		}
		override public function addViews(signal:BaseSignal):void {
			
			view.add(new StatisticsView(), Language.STATISTICS);
			view.add(new PlayersUIView(), Language.PLAYERS);
			view.add(new WinnersUIView(), Language.WINNERLIST);
			view.add(new SideBetSpotsView(), Language.PLAYERSBETS);
			view.add(new FavouritesBetsView(), Language.FAVOURITES);
			
			view.display.addEventListener(AccordionEvent.SELECTED,doSelected);

			resize();
		}
		private function doSelected(evt:AccordionEvent):void{
			if (evt.label==Language.PLAYERSBETS)
			{
				signalBus.dispatch(VideoEvent.FULLSCREEN);
			}
		}
	}
}