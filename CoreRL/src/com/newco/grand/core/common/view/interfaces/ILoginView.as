package com.newco.grand.core.common.view.interfaces
{
	import org.osflash.signals.Signal;

	public interface ILoginView extends IUIView
	{
		function set id(value:String):void;
		
		function get id():String;
		function get password():String;
		
		function set password(value:String):void;
		function set error(value:String):void;
		function get loginSignal():Signal
	}
}