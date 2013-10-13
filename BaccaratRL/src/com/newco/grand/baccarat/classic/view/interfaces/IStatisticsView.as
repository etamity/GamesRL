package com.newco.grand.baccarat.classic.view.interfaces
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	
	import org.osflash.signals.Signal;

	public interface IStatisticsView extends IUIView
	{
		function load(data:XML):void;
		function get showHideSignal():Signal;
		function set extended(val:Boolean):void;
		function get extended():Boolean;
	}
}