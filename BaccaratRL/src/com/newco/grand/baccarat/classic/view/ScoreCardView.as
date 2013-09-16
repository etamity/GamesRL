package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.interfaces.IScoreCardView;
	import com.newco.grand.core.common.components.scorecard.ScoreCard;
	import com.newco.grand.core.common.model.StyleModel;
	import com.newco.grand.core.common.view.UIView;
	
	import flash.display.SimpleButton;
	
	public class ScoreCardView extends UIView implements IScoreCardView
	{
		private var scoreCardPanel:ScoreCard;
		private var _closeBtn:SimpleButton;
		protected var _skin:ScorecardBG;
		public function ScoreCardView()
		{
			super();
		}
		
		override public function initDisplay():void{
			 _skin= new ScorecardBG();
			addChild( _skin);
			scoreCardPanel=new ScoreCard();
			addChild(scoreCardPanel);
			scoreCardPanel.x=10;
			scoreCardPanel.y=5;
			_display= _skin;
	
		}
		
		override public function updateLanguage():void{
			scoreCardPanel.updateLanguage();
		}
		override public function align():void {
			x=0;
			y=0;
			visible=true;
		}

		public function get closeBtn():SimpleButton{
			return _closeBtn;
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