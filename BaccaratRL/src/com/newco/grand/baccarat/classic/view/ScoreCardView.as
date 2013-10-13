package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.interfaces.IScoreCardView;
	import com.newco.grand.core.common.components.scorecard.ScoreCard;
	import com.newco.grand.core.common.model.StyleModel;
	import com.newco.grand.core.common.view.SMButton;
	import com.newco.grand.core.common.view.UIView;
	
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	public class ScoreCardView extends UIView implements IScoreCardView
	{
		private var scoreCardPanel:ScoreCard;
		private var _closeBtn:SMButton;
		protected var _skin:ScorecardBG;
		protected var _extended:Boolean=false;
		public function ScoreCardView()
		{
			super();
		}
		
		override public function initDisplay():void{
			 _skin= new ScorecardBG();
			addChild( _skin);
			scoreCardPanel=new ScoreCard();
			addChild(scoreCardPanel);
			scoreCardPanel.x=5;
			scoreCardPanel.y=5;
			_display= _skin;
			_closeBtn=new SMButton(_skin.closeBtn);
			
			_closeBtn.skin.addEventListener(MouseEvent.CLICK,doShowHide);
		}
		private function doShowHide(evt:MouseEvent):void{
			extended=!extended;
		}
		public function get extended():Boolean{
			return _extended;
		}
		public function set extended(val:Boolean):void{

			if (_extended==false){
				
				Tweener.addTween(view,{x:-375,time:0.5,onComplete:function ():void{}});
			}else{
				Tweener.addTween(view,{x:0,time:0.5,onComplete:function ():void{}});	
			}
			_extended=val;
		}
		override public function updateLanguage():void{
			scoreCardPanel.updateLanguage();
		}
		override public function align():void {
			x=0;
			y=0;
			visible=true;
		}

		public function get closeBtn():SMButton{
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