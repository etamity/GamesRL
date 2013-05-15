package com.ai.baccarat.classic.view.scorecard.display.road {
	
	import com.ai.baccarat.classic.view.scorecard.display.road.result.IResult;
	
	public interface IRoadModifiable extends IRoad {
		function addResult(result:IResult, xPos:uint, yPos:uint):void
	}
}