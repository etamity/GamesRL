package com.ai.core.model
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class Actor
	{
		[Inject]
		public var eventDispatcher:IEventDispatcher;
			
		protected function dispatch(e:Event):void
		{
			if(eventDispatcher.hasEventListener(e.type))
				eventDispatcher.dispatchEvent(e);
		}
	}
}
