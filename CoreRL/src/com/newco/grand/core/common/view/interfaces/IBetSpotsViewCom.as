package com.newco.grand.core.common.view.interfaces
{
	import org.osflash.signals.Signal;

	public interface IBetSpotsViewCom extends IUIView
	{
		function getTotalBet():Number;
		function get chipSelecedValue():Number;
		function get balance():Number;
		function set balance(value:Number):void;
		function set chipSelecedValue(value:Number):void;
	
	}
}