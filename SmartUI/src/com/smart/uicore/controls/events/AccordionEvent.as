package com.smart.uicore.controls.events
{
	import flash.events.Event;

	public class AccordionEvent extends Event
	{
		public static const SELECTED:String = "AccordionEvent.SELECTED";
		
		private var _tabIndex:uint;
		private var _label:String;
		
		public function AccordionEvent(type:String,tabIndex:uint,labelName:String)
		{
			super(type);
			_tabIndex = tabIndex;
			_label = labelName;
		}
		
		public function get index():uint{
			return _tabIndex;
		}
		
		public function get label():String{
			return _label;
		}
		
	}
}