package com.ai.baccarat.classic.view.mediators
{
	import com.ai.baccarat.classic.view.BetspotsPanelView;
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.model.Language;
	import com.ai.core.view.WinnersView;
	import com.ai.core.view.mediators.AccordionMediator;
	import com.ai.core.view.uicomps.PlayersUIView;
	
	public class BaccaratAccordionMediator extends AccordionMediator
	{
		public function BaccaratAccordionMediator()
		{
			super();
		}
		override public function addViews(signal:BaseSignal):void {
			view.add(new PlayersUIView(), Language.PLAYERS);
			view.add(new WinnersView(), Language.WINNERLIST);
			view.add(new BetspotsPanelView(), Language.BACCARAT_BETSPOTSPANEL);
			//view.add(new PlayersBetsView(), Language.PLAYERSBETS);
			//view.add(new FavouritesBetsView(), Language.FAVOURITES);
		}
	}
}