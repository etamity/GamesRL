package com.newco.grand.baccarat.mobile.view
{
	import com.newco.grand.baccarat.classic.view.ScoreCardView;
	import com.newco.grand.baccarat.classic.view.interfaces.IScoreCardView;
	import caurina.transitions.Tweener;
	public class ScoreCardView extends com.newco.grand.baccarat.classic.view.ScoreCardView implements IScoreCardView
	{
		public function ScoreCardView()
		{
			super();
		}
		override public function align():void{
			x= 55;
			visible=true;
		}
		override public function set extended(val:Boolean):void{
			if (_extended==false){
				
				Tweener.addTween(view,{x:-305,time:0.5,onComplete:function ():void{}});
			}else{
				Tweener.addTween(view,{x:55,time:0.5,onComplete:function ():void{}});	
			}
			_extended=val;
		}
	}
}