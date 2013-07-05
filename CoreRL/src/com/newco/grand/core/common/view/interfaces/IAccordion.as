package com.newco.grand.core.common.view.interfaces
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public interface IAccordion extends IUIView
	{		
		function add(mc:MovieClip, title:String, toolTipMsg:String = ""):void;
		function get contentHeight():int;
		function set compHeight(val:int):void;
		function get compHeight():int;
		function get view():Sprite;
	}
}