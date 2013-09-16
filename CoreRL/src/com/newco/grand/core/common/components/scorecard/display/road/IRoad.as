package com.newco.grand.core.common.components.scorecard.display.road {
	
	import com.newco.grand.core.common.components.scorecard.display.IAcceptsResult;
	import com.newco.grand.core.common.components.scorecard.display.road.behaviours.IAddBehaviour;
	import com.newco.grand.core.common.components.scorecard.display.road.result.IResult;

	public interface IRoad extends IAcceptsResult {
		function getSubset(startX:int, startY:int, endX:int, endY:int):Array
		function set addBehaviour(v:IAddBehaviour):void
		function get lastResult():IResult
		function get lastXPos():uint
		function get lastYPos():uint
	}
}