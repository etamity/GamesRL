package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.interfaces.IScoreCardView;
	import com.newco.grand.core.common.model.StyleModel;
	import com.newco.grand.core.components.scorecard.ScoreCard;
	
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	public class ScoreCardView extends Sprite implements IScoreCardView
	{
		private var scoreCardPanel:ScoreCard;
		private var _closeBtn:SimpleButton;
		protected var _display:*;
		public function ScoreCardView()
		{
			super();
			initDisplay();
			visible=false;
		}
		
		public function initDisplay():void{
			_display= new ScorecardBG();
			addChild(_display);
			scoreCardPanel=new ScoreCard();
			addChild(scoreCardPanel);
			scoreCardPanel.x=10;
			scoreCardPanel.y=5;
	
		}
		public function get display():*{
			return this;
		}
		public function init():void {
			align();
		}
		public function get closeBtn():SimpleButton{
			return _closeBtn;
		}
		public function align():void {
			x=0;
			y=0;
			visible=true;
		}
		public function update(data:XMLList):void{
			scoreCardPanel.generateScorecard(data);
		}
		
		public function initView(width:Number = 200, height:Number = 200, showTabs:Boolean = true, showAllRoadsAtOnce:Boolean = false, tableId:String = ""):void{
			scoreCardPanel.init(width,height,showTabs,showAllRoadsAtOnce,tableId, StyleModel.getColor(StyleModel.DEFAULTBTNCOLOR1));
			visible=true;
		}
	}
}