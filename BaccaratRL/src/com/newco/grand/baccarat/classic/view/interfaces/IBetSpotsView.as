package com.newco.grand.baccarat.classic.view.interfaces
{
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.interfaces.IBetSpotsViewCom;
	
	import flash.utils.Dictionary;
	
	public interface IBetSpotsView extends IBetSpotsViewCom
	{
		function setMode(mode:String="pairs"):void;
		function clearBets():void;
		function createBet(value:int, i:int):void;
		function get betString():String;
		function getBetspotAmount(side:String):Number;

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