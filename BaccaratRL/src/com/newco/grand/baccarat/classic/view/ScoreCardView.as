package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.core.common.model.Style;
	import com.newco.grand.core.common.view.scorecard.ScoreCard;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	public class ScoreCardView extends Sprite
	{
		private var scoreCardPanel:ScoreCard;
		private var _closeBtn:SimpleButton;
		public function ScoreCardView()
		{
			super();
			scoreCardPanel=new ScoreCard();
			var bg:MovieClip=new ScorecardBG();
			//_closeBtn=bg.closeBtn;
			addChild(bg);
			addChild(scoreCardPanel);
			scoreCardPanel.x=10;
			scoreCardPanel.y=5;
			visible=false;
		}
		public function get closeBtn():SimpleButton{
			return _closeBtn;
		}
		public function align():void {
			x=0;
			y=0;
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