package com.ai.baccarat.classic.view
{
	import com.ai.core.utils.GameUtils;
	
	import caurina.transitions.Tweener;

	public class Card extends CardAsset
	{
		private var _side:String="";
		private var _value:int=0;
		private var _id:int;
		private var _label:String;
		public function Card(value:String=null,side:String=null)
		{
			super();
			_side=side;
			this.stop();
			mcCard.visible=false;
			_id=int(value);
			_value=GameUtils.findBaccaratCardValue(_id);
			_label=GameUtils.findBaccaratCardLabel(_id);
			setCard(_label);
			
		}
		public function get side():String{
			return _side;
		}
		public function get value():int{
			return _value;
		}
		public function get label():String{
			return _label;
		}
		
		private function flipCard(card:Card):void{
			function onFinishedCardFlip(card:Card):void{
				this.gotoAndStop("frontside");
				Tweener.addTween(card,{rotationY:0, time: 0.2});
			}
				Tweener.addTween(card,{rotationY:-100, time: 0.1,onComplete:onFinishedCardFlip,onCompleteParams:[card]});

		}
		
		public function showCard():void{
			mcCard.visible=true;
			flipCard(this);
		}
		public function backCard():void{
			this.gotoAndStop("backside");
		}
		public function setCard(value:String):void{
			debug(value);
			if(value !="" && value!=null)	
			mcCard.gotoAndStop(value);
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}