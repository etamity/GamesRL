package com.newco.grand.core.common.view.interfaces
{
	import flash.display.MovieClip;

	public interface IAccordion extends IUIView
	{		
		function add(mc:MovieClip, title:String, toolTipMsg:String = ""):void;
		function get contentHeight():int;
	}
}