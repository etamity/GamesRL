package com.ai.roulette.classic.view.mediators
{
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.model.Language;
	import com.ai.core.view.mediators.AccordionMediator;
	import com.ai.roulette.classic.view.FavouritesBetsView;
	import com.ai.core.view.PlayersView;
	import com.ai.roulette.classic.view.StatisticsView;
	import com.ai.core.view.WinnersView;
	
	public class RouletteAccordionMediator extends AccordionMediator
	{
		public function RouletteAccordionMediator()
		{
			super();
		}
		override public function addViews(signal:BaseSignal):void {
			
			view.add(new StatisticsView(), Language.STATISTICS);
			view.add(new PlayersView(), Language.PLAYERS);
			view.add(new WinnersView(), Language.WINNERLIST);
			//view.add(new PlayersBetsView(), Language.PLAYERSBETS);
			view.add(new FavouritesBetsView(), Language.FAVOURITES);
		}
	}
}