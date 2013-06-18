package com.newco.grand.roulette.classic.view.mediators
{
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.model.Language;
	com.ai.core.common.view.mediators.AccordionMediatorediator;
	import com.ai.core.common.view.uicomps.PlayersUIView;
	import com.ai.core.common.view.uicomps.WinnersUIView;
	import com.newco.grand.roulette.classic.view.FavouritesBetsView;
	import com.newco.grand.roulette.classic.view.StatisticsView;
	
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
			//view.add(new PlayersBetsView(), Language.PLAYERSBETS);
			view.add(new FavouritesBetsView(), Language.FAVOURITES);
			resize();
		}
	}
}