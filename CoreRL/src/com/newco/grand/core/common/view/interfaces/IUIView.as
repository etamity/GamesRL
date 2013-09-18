package com.newco.grand.core.common.view.interfaces
{
	import flash.display.Sprite;

	public interface IUIView
	{
		function init():void;
		function align():void;
		function get view():Sprite;
		function initDisplay():void;
		
		function updateLanguage():void;
	}
}