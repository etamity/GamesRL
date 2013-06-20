package com.newco.grand.baccarat.classic.view.interfaces
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	
	public interface ICardsPanelView extends IUIView
	{
		function issueCard(side:String,value:String):void;
		function cleanPanel():void;
	}
}