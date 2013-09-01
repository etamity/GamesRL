package com.slc.games.help.events {

	import flash.events.Event;

	/**
	 * Events dispatched from the Statistics Controller.
	 *
	 * @author Elliot Harris
	 */
	public class HelpControllerEvent extends Event {
		/**
		 * Dispatched when the main XML has completed loading and has been saved to the model.
		 */
		public static const XML_COMPLETE:String       = "xmlComplete";

		/**
		 * Dispatched when the XML for a specific help page has completed loading and has
		 * been saved to the model.
		 */
		public static const HELP_PAGE_COMPLETE:String = "helpPageComplete";

		public function HelpControllerEvent(type:String) {
			super(type, false, false);
		}

	}
}

