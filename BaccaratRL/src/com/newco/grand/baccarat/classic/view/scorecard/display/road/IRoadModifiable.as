package com.newco.grand.lobby.classic.view.scorecard.display.road {
	
	import com.newco.grand.lobby.classic.view.scorecard.display.road.result.IResult;
	
	public interface IRoadModifiable extends IRoad {
		function addResult(result:IResult, xPos:uint, yPos:uint):void
	}
}