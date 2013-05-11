package com.ai.roulette.view {
	import flash.events.MouseEvent;
	
	public class LimitsView extends LimitsAsset {
		
		public function LimitsView() {
			visible = false;
			allLimitsMC.visible = false;
			addEventListener(MouseEvent.CLICK, showAllLimits);
			useHandCursor = true;
		}
		
		public function init():void {
			align();
		}
		
		public function align():void {			
			x = 172;
			y = 462;
		}
		
		private function showAllLimits(event:MouseEvent):void {
			allLimitsMC.visible = !allLimitsMC.visible;
		}
		
		public function addLimits(label:String, min:Number, max:int, payout:int, index:int):void {
			var row:LimitsMC = new LimitsMC();
			allLimitsMC.addChild(row);
			row.bet.htmlText = "<b>"+label+"</b>";
			row.min.text = "" + min;
			row.max.text = "" + max;
			row.payout.text = "" + payout;
			row.y = index * row.height + row.height + 5;
		}
		
		public function set titleLabel(value:String):void {
			titleLbl.htmlText = '<b>'+value+'</b>';
		}
		
		public function set minLabel(value:String):void {
			minLbl.htmlText = '<b>'+value+'</b>';
			allLimitsMC.minLbl.text = value;
		}
		
		public function set minLimit(value:String):void {
			min.text = value;
		}
		
		public function set maxLabel(value:String):void {
			maxLbl.htmlText = '<b>'+value+'</b>';
			allLimitsMC.maxLbl.text = value;
			visible = true;
		}
		
		public function set maxLimit(value:String):void {
			max.text = value;
		}
		
		public function set betLabel(value:String):void {
			allLimitsMC.betLbl.text = value;
		}
		
		public function set payoutLabel(value:String):void {
			allLimitsMC.payoutLbl.text = value;
		}
	}
}