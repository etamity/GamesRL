package com.ai.core.view.ui.buttons {

	import flash.events.Event;
	import flash.events.MouseEvent;

	public class GeneralButtonEvent extends Event {
		public static const MOUSE_OVER:String = "buttonMouseOver";
		public static const MOUSE_DOWN:String = "buttonMouseDown";
		public static const MOUSE_OUT:String  = "buttonMouseOut";
		public static const MOUSE_UP:String   = "buttonMouseUp";
		public static const CLICK:String      = "buttonClick";

		private var _mouseEvent:MouseEvent;
		private var _id:int;

		public function GeneralButtonEvent(type:String, mouseEvent:MouseEvent = null, id:int = -1) {
			super(type, true, true);

			_mouseEvent = mouseEvent;
			_id = id;
		}

		public function get mouseEvent():MouseEvent {
			return _mouseEvent;
		}

		public function get id():int {
			return _id;
		}

	}
}

