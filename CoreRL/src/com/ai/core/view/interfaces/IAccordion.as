package com.ai.core.view.interfaces
{
	import flash.display.MovieClip;

	public interface IAccordion
	{		
		function init():void;
		function align():void;
		function add(mc:MovieClip, title:String, toolTipMsg:String = ""):void;
	}
}