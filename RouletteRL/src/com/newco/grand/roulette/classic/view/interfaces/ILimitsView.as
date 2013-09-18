package com.newco.grand.roulette.classic.view.interfaces
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	
	public interface ILimitsView extends IUIView
	{
		function set minLabel(val:String):void;
		function set maxLabel(val:String):void;
		function set titleLabel(val:String):void;
		function set betLabel(val:String):void;
		function set payoutLabel(val:String):void;
		function set minLimit(val:String):void;
		function set maxLimit(val:String):void;
		function addLimits(label:String, min:Number, max:int, payout:int, index:int):void;
	}
}