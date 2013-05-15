package com.ai.baccarat.classic.view.scorecard.display.road {
	
	import com.ai.baccarat.classic.view.scorecard.display.IAcceptsResult;
	import com.ai.baccarat.classic.view.scorecard.display.road.behaviours.IAddBehaviour;
	import com.ai.baccarat.classic.view.scorecard.display.road.result.IResult;

	public interface IRoad extends IAcceptsResult {
		function getSubset(startX:int, startY:int, endX:int, endY:int):Array
		function set addBehaviour(v:IAddBehaviour):void
		function get lastResult():IResult
		function get lastXPos():uint
		function get lastYPos():uint
	}
}