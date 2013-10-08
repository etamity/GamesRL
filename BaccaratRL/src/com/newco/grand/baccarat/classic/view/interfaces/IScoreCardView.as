package com.newco.grand.baccarat.classic.view.interfaces
{
	import com.newco.grand.core.common.view.SMButton;
	import com.newco.grand.core.common.view.interfaces.IUIView;
	
	import flash.display.SimpleButton;
	
	public interface IScoreCardView extends IUIView
	{
		function get closeBtn():SMButton;
		function update(data:XMLList):void;
		function initView(width:Number = 200, height:Number = 200, showTabs:Boolean = true, showAllRoadsAtOnce:Boolean = false, tableId:String = ""):void;
	}
}