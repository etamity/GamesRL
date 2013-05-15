package com.ai.baccarat.view.mediators
{
	import com.ai.baccarat.view.BetspotsPanelView;
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.model.Language;
	import com.ai.core.view.PlayersView;
	import com.ai.core.view.WinnersView;
	import com.ai.core.view.mediators.AccordionMediator;
	
	public class BaccaratAccordionMediator extends AccordionMediator
	{
		public function BaccaratAccordionMediator()
		{
			super();
		}
		override public function addViews(signal:BaseSignal):void {
			view.add(new PlayersView(), Language.PLAYERS);
			view.add(new WinnersView(), Language.WINNERLIST);
			view.add(new BetspotsPanelView(), Language.BACCARAT_BETSPOTSPANEL);
			//view.add(new PlayersBetsView(), Language.PLAYERSBETS);
			//view.add(new FavouritesBetsView(), Language.FAVOURITES);
		}
	}
}