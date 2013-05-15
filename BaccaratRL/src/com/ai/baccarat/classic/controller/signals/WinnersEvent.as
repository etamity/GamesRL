package com.ai.baccarat.classic.controller.signals {
	

	
	public class WinnersEvent {
		
		public static const LOAD:String = "WinnersEvent.LOAD";
		public static const LOADED:String = "WinnersEvent.LOADED";
		
		private var _xml:XML;

		public function get xml():XML {
			return _xml;
		}
		
		public function set xml(value:XML):void {
			_xml = value;
		}
	}
}