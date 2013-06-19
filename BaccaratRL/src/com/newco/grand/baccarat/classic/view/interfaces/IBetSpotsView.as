package com.newco.grand.baccarat.classic.view.interfaces
{
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.interfaces.IUIView;
	
	import flash.utils.Dictionary;
	
	import org.osflash.signals.Signal;
	
	public interface IBetSpotsView extends IUIView
	{
		function get makeBetSignal():Signal;
		function setMode(mode:String="pairs"):void;
		function enabledBetting(val:Boolean):void;
		function makeBet(value:Number,side:String):void;
		function resize(width:Number,height:Number):void;
		function clearBets():void;
		function createBet(value:int, i:int):void;
		function get betString():String;
		function set chipSelecedValue(value:Number):void;
		function getBetspotAmount(side:String):Number;
		function get chipSelecedValue():Number;
		function get balance():Number;
		function set balance(value:Number):void;
		function getTotalBet():Number;
		function enableBetting():void;
		function repeat():void;
		function double():void;
		function undo():void;
		function getWinnings(code:String):Number;
		function get lastBet():Number;
		function getPairsWinnings(code:String):Number;
		function disableBetting():void;
		function setLimits(i:int,min:int, max:int):void;
		
		function registerPoints(dictionary:Dictionary):void;
		function get signalBus():SignalBus;
	}
}