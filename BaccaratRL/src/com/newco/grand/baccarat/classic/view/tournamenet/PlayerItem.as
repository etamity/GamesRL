package com.newco.grand.baccarat.classic.view.tournamenet  {
	
	public class PlayerItem extends PlayerItemSkin{

		public function PlayerItem() {
			
		}
		
		public function set label(value:String):void {
			this.labelTxt.text = value;
		}
		
		public function set points(value:int):void {
			this.pointsTxt.text = value + " pts";
		}

	}
	
}
