package com.newco.grand.roulette.classic.view {
	
	
	public class StageInfoView extends StageInfoAsset {
		
		private var _xml:XML;
		private var _results:Array = new Array();
		private var _historyLoaded:Boolean = false;
		
		public function StageInfoView() {
			txt.text = "STAGE TEST";
		}

		public function get info():String {
			return txt.text;
		}

		public function set info(value:String):void {
			txt.text = value;
		}
	}
}