package com.ai.core.view.interfaces
{
	import flash.display.MovieClip;

	public interface IAccordion extends IUIView
	{		
		function add(mc:MovieClip, title:String, toolTipMsg:String = ""):void;
	}
}