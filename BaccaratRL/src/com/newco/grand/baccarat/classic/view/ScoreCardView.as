package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.scorecard.ScoreCard;
	import com.ai.core.common.model.Style;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class ScoreCardView extends Sprite
	{
		private var scoreCardPanel:ScoreCard;
		public function ScoreCardView()
		{
			super();
			scoreCardPanel=new ScoreCard();
			var bg:MovieClip=new ScorecardBG();
			addChild(bg);
			addChild(scoreCardPanel);
			scoreCardPanel.x=10;
			scoreCardPanel.y=5;
			visible=false;
		}
		
		public function align():void {
			x=stage.stageWidth-scoreCardPanel.width-25;
			y=210;
		}
		public function update(data:XMLList):void{
			scoreCardPanel.generateScorecard(data);
		}
		
		public function init(width:Number = 200, height:Number = 200, showTabs:Boolean = true, showAllRoadsAtOnce:Boolean = false, tableId:String = ""):void{
			scoreCardPanel.init(width,height,showTabs,showAllRoadsAtOnce,tableId, Style.getColor(Style.DEFAULTBTNCOLOR1));
			visible=true;
		}
	}
}