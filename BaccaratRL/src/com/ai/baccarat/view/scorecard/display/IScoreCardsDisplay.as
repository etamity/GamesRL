package com.ai.baccarat.view.scorecard.display {
	
	public interface IScoreCardsDisplay extends IAcceptsResult {
		function init(width:Number = 200, height:Number = 200, showTabs:Boolean = true, showAllRoadsAtOnce:Boolean = false):void
	}
}