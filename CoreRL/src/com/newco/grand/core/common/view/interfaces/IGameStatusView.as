package com.newco.grand.core.common.view.interfaces
{
	public interface IGameStatusView extends IUIView
	{
		function set timerColor(value:uint):void;
		function set timer(value:String):void;
		function setLightSOff():void;
		function setLightOn(label:String):void;
		function set message(value:String):void;
		function highlightMessageBG(clr:uint = 0x990000):void;
	}
}