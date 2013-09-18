package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.interfaces.IStatisticsView;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.UIView;
	
	public class StatisticsView extends UIView implements IStatisticsView
	{

		public function StatisticsView()
		{
			super();
			
		}
		public function load(data:XML):void{
			
		}
		override public function updateLanguage():void{
			_display.titleLabel.text= LanguageModel.STATISTICS;
			_display.bankerLabel.text=LanguageModel.BANKER;
			_display.playerLabel.text=LanguageModel.PLAYER;
			_display.tieLabel.text=LanguageModel.TIE;
			_display.bankerPairLabel.text=LanguageModel.PAIR_BANKER;
			_display.playerPairLabel.text=LanguageModel.PAIR_PLAYER;
			_display.naturalLabel.text=LanguageModel.NATURAL;
			_display.gameNumLabel.text=LanguageModel.GAMENUMBER;
		}
		override public function initDisplay():void{
			_display=new ShoeStatsAsset();
			addChild(_display);
		}
		
		override public function align():void{
			x=stage.stageWidth-width;
		}
	}
}