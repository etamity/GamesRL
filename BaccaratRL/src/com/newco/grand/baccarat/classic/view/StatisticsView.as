package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.view.interfaces.IStatisticsView;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.SMButton;
	import com.newco.grand.core.common.view.UIView;
	
	import flash.events.MouseEvent;
	
	import caurina.transitions.Tweener;
	
	import org.osflash.signals.Signal;
	
	public class StatisticsView extends UIView implements IStatisticsView
	{
		private var _closeBtn:SMButton;
		protected var _extended:Boolean=false;
		
		private var _showHideSignal:Signal=new Signal();
		
		public function StatisticsView()
		{
			super();
			
		}
		
		public function get showHideSignal():Signal{
			return _showHideSignal;
		}
			
		private function doShowHide(evt:MouseEvent):void{
			extended=!extended;
			_showHideSignal.dispatch(extended);
		}
		public function get extended():Boolean{
			return _extended;
		}
		public function set extended(val:Boolean):void{
			
			if (_extended==false){
				
				Tweener.addTween(view,{x:stage.stageWidth-15,time:0.5,onComplete:function ():void{}});
			}else{
				Tweener.addTween(view,{x:970,time:0.5,onComplete:function ():void{}});	
			}
			_extended=val;
		}
		public function load(data:XML):void{
			_display.bankerValue.text=data.Banker;
			_display.playerValue.text=data.Player;
			_display.tieValue.text=data.Tie;
			_display.bankerPairValue.text=data.Banker_Pair;
			_display.playerPairValue.text=data.Player_Pair;
			_display.naturalValue.text=data.Natural;
			_display.gameNumValue.text=data.Game_Number;
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
			_closeBtn=new SMButton(_display.closeBtn);
			_closeBtn.skin.addEventListener(MouseEvent.CLICK,doShowHide);
		}
		
		override public function align():void{
			x=stage.stageWidth-width;
		}
	}
}