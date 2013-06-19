package com.newco.grand.baccarat.classic.view.interfaces
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	
	import org.osflash.signals.Signal;
	
	public interface IBetspotsPanelView extends IUIView
	{
		function get makeBetSignal():Signal;
		function setMode(mode:String="pairs"):void;
		function enabledBetting(val:Boolean):void;
		function makeBet(value:Number,side:String):void;
		function resize(width:Number,height:Number):void;
		function clearBets():void;
	}
}