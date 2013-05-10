package com.ai.baccarat.controller.signals
{
	import flash.events.Event;

	public class BaccaratEvent
	{	
		public static const PAIRRESULT:String = "BaccaratEvent.PAIRRESULT";
		public static const INSURANCETIMER:String = "BaccaratEvent.INSURANCETIMER";
		public static const INSURANCE:String = "BaccaratEvent.INSURANCE";
		public static const CARDMOVE:String = "BaccaratEvent.CARDMOVE";
		public static const DECISION:String = "BaccaratEvent.DECISION";
		public static const DECISIONINC:String = "BaccaratEvent.DECISIONINC";
		public static const SCORDCARD:String = "BaccaratEvent.SCORDCARD";
		public static const KICKOUT:String = "BaccaratEvent.KICKOUT";
		public static const COMMAND:String = "BaccaratEvent.COMMAND";
		
		public static const CARD:String = "BaccaratEvent.CARD";
		public static const CARDINC:String = "BaccaratEvent.CARDINC";
		
		private var _xml:XML;
		
		public function get xml():XML {
			return _xml;
		}
		
		public function set xml(value:XML):void {
			_xml = value;
		}
	}
}