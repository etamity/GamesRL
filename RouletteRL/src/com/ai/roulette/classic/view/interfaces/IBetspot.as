package com.ai.roulette.classic.view.interfaces
{
	public interface IBetspot
	{
		
		function placebet(value:Number):void;
		
		function highLight():void;
		
		function removeHighlight():void;
		
		function undo():void;
		
		function repeat():void;
		
		function double():void;
		
		function clear():void;
		
		
	}
}