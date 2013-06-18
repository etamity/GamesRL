package com.newco.grand.baccarat.classic.controller.signals {

	
	public class StatisticsEvent {
		
		public static const LOAD:String = "StatisticsEvent.LOAD";
		public static const LOADED:String = "StatisticsEvent.LOADED";
		
		private var _xml:XML;

		
		public function get xml():XML {
			return _xml;
		}
		
		public function set xml(value:XML):void {
			_xml = value;
		}
	}
}