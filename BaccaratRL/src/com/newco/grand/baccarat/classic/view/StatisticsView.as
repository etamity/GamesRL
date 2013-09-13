package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.interfaces.IStatisticsView;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.UIView;
	
	public class StatisticsView extends UIView implements IStatisticsView
	{

		protected var _skin:ShoeStatsAsset;
		public function StatisticsView()
		{
			super();
			
		}
		public function load(data:XML):void{
			
		}
		override public function updateLanguage():void{
			_skin.titleLabel.text= LanguageModel.STATISTICS;
			_skin.bankerLabel.text=LanguageModel.BANKER;
			_skin.playerLabel.text=LanguageModel.PLAYER;
			_skin.tieLabel.text=LanguageModel.TIE;
			_skin.bankerPairLabel.text=LanguageModel.PAIR_BANKER;
			_skin.playerPairLabel.text=LanguageModel.PAIR_PLAYER;
			_skin.naturalLabel.text=LanguageModel.NATURAL;
			_skin.gameNumLabel.text=LanguageModel.GAMENUMBER;
		}
		override public function initDisplay():void{
			_skin=new ShoeStatsAsset();
			addChild(_skin);
			_display=_skin;
		}
		
		override public function align():void{
			x=stage.stageWidth-width;
		}
	}
}