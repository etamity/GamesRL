package com.newco.grand.roulette.classic.view {
	import com.newco.grand.core.common.view.UIView;
	import com.newco.grand.roulette.classic.view.interfaces.ILimitsView;
	
	import flash.events.MouseEvent;
	
	public class LimitsView extends UIView implements ILimitsView {

		public function LimitsView() {
			super();
			visible = false;
			_display.allLimitsMC.visible = false;
			addEventListener(MouseEvent.CLICK, showAllLimits);
			useHandCursor = true;
		}
		override public function initDisplay():void{
			_display=new LimitsAsset();
			addChild(_display);
		}
		
		override public function align():void {			
			x = 172;
			y = 462;
		}
		
		private function showAllLimits(event:MouseEvent):void {
			_display.allLimitsMC.visible = !_display.allLimitsMC.visible;
		}
		
		public function addLimits(label:String, min:Number, max:int, payout:int, index:int):void {
			var row:LimitsMC = new LimitsMC();
			_display.allLimitsMC.addChild(row);
			row.bet.htmlText = "<b>"+label+"</b>";
			row.min.text = "" + min;
			row.max.text = "" + max;
			row.payout.text = "" + payout;
			row.y = index * row.height + row.height + 5;
		}
		
		public function set titleLabel(value:String):void {
			_display.titleLbl.htmlText = '<b>'+value+'</b>';
		}
		
		public function set minLabel(value:String):void {
			_display.minLbl.htmlText = '<b>'+value+'</b>';
			_display.allLimitsMC.minLbl.text = value;
		}
		
		public function set minLimit(value:String):void {
			_display.min.text = value;
		}
		
		public function set maxLabel(value:String):void {
			_display.maxLbl.htmlText = '<b>'+value+'</b>';
			_display.allLimitsMC.maxLbl.text = value;
			visible = true;
		}
		
		public function set maxLimit(value:String):void {
			_display.max.text = value;
		}
		
		public function set betLabel(value:String):void {
			_display.allLimitsMC.betLbl.text = value;
		}
		
		public function set payoutLabel(value:String):void {
			_display.allLimitsMC.payoutLbl.text = value;
		}
	}
}