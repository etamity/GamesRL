package com.newco.grand.core.common.components.scorecard.display.road {
	
	import com.newco.grand.core.common.components.scorecard.display.road.result.IResult;
	
	public interface IRoadModifiable extends IRoad {
		function addResult(result:IResult, xPos:uint, yPos:uint):void
	}
}