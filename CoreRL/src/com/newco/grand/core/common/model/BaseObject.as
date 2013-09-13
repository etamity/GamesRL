package com.newco.grand.core.common.model
{
	import com.newco.grand.core.common.model.interfaces.IBaseObject;
	
	import robotlegs.bender.framework.api.ILogger;
	
	public class BaseObject implements IBaseObject
	{
		[Inject]
		public var logger:ILogger
		
		public function BaseObject()
		{
		}
		
		public function debug(...args):void
		{
			logger.debug(args);
		}
		public function toString():String{
			return null;
		}
	}
}