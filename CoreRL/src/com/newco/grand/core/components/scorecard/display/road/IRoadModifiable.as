package com.newco.grand.core.components.scorecard.display.road {
	
	import com.newco.grand.core.components.scorecard.display.road.result.IResult;
	
	public interface IRoadModifiable extends IRoad {
		function addResult(result:IResult, xPos:uint, yPos:uint):void
	}
}