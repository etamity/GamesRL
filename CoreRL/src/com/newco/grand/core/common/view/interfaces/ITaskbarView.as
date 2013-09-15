package com.newco.grand.core.common.view.interfaces
{
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.SMButton;

	public interface ITaskbarView extends IUIView
	{
		function get clearButton():SMButton;
		function get undoButton():SMButton;
		function get repeatButton():SMButton;

		function get doubleButton():SMButton;
		function get confirmButton():SMButton;
		function get favouritesButton():SMButton;
		function disableButtons():void;
		function get chips():Array;
		function set chips(value:Array):void;
		function set balance(value:String):void;
		function set bet(value:String):void;
		function enableDouble():void;
		function disbleDouble():void;
		function enableRepeat():void;
		function enableChips():void;
		
		function disbleChips():void;
		function enableClear():void;
		function enableConfirm():void;
		function enableUndo():void;
		function disbleClear():void;
		function disbleUndo():void;
		function enableFavourites():void;
		
		
		function disbleRepeat():void;
		function disbleConfirm():void;
		function disbleFavourites():void;
		function showTooltip(target:Object, txt:String):void;
		
		function slideUpButtons():void;
		function slideDownButtons():void;
		
		function get signalBus():SignalBus;
		function myAccountEnabled(val:Boolean):void;
		function get chipSelected():Number;
		function set chipSelected(value:Number):void;
		function set myAccountURL(value:String):void;
		function set balanceLabel(value:String):void 
		function createMenuItem(label:String, url:String):void;
		function set myaccountLabel(value:String):void;
		function set game(value:String):void;
		
		function loadLanguages(data:XML):void;
	}
	
}