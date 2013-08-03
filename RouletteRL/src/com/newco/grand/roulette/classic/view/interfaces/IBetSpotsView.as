package com.newco.grand.roulette.classic.view.interfaces
{
	import com.newco.grand.core.common.view.interfaces.IBetSpotsViewCom;
	import org.osflash.signals.Signal;
	public interface IBetSpotsView extends IBetSpotsViewCom
	{
		function clearBets():void;
		function placeFavouritesBets(betstring:String):void;
		function undo():void;
		function get betString():String;
		function disableBetting():void;
		function get betBatch():Object;
		function double():void;
		function createBet(value:int, i:int):void;
		function highlightSpot(value:String):void;
		function removeHighlightSpot(value:String):void;
		function set chipSelected(value:Number):void;
		
		function get chipSelected():Number;
		
		function get updateBetSignal():Signal;
		function get messageSignal():Signal;
		function get neighbourBetsSignal():Signal;
		function get hightLightSignal():Signal;
		function get removeLightSignal():Signal;
		function showWinningNumber(i:int):void;
		function get lastBet():Number;
		function getWinnings(i:int, payout:int):Number;
		function repeat():void;
		function setLimits(i:int, min:int, max:int):void;
		function enableBetting():void;
	}
}