package com.slc.games.history.events {

	import flash.events.Event;

	/**
	 * Events dispatched from the History Controller.
	 *
	 * @author Elliot Harris
	 */
	public class HistoryControllerEvent extends Event {
		/**
		 * Dispatched when some view-specific XML has completed loading and has been saved to the model.
		 */
		public static const VIEW_XML_COMPLETE:String = "viewXMLComplete";

		public function HistoryControllerEvent(type:String) {
			super(type, false, false);

		}

		public override function clone():Event {
			return new HistoryControllerEvent(type);
		}

		public override function toString():String {
			return formatToString("HistoryControllerEvent", "type", "bubbles", "cancelable", "eventPhase");
		}

	}

}

