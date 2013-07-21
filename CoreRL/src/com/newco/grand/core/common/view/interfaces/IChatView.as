package com.newco.grand.core.common.view.interfaces
{
	import org.osflash.signals.Signal;

	public interface IChatView extends IUIView
	{
		function set dealer(value:String):void;

		function setMessage(sender:String, message:String):void;
		function setWelcomeMessage(message:String):void ;
		function get sendSignal():Signal;
		function get message():String ;
		function clear():void;
	}
}