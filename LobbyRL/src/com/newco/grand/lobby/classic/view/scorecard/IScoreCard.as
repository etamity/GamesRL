package com.newco.grand.lobby.classic.view.scorecard {
	
	import com.newco.grand.lobby.classic.view.scorecard.display.IScoreCardsDisplay;
	
	public interface IScoreCard {
		function init(width:Number=200, height:Number=200, showTabs:Boolean=true, showAllRoadsAtOnce:Boolean=false, tableId:String = "", txtClr:uint = 0xFFFFFF, url:String = ""):void
		function loadResults():void
		function get scoreCardsDisplay():IScoreCardsDisplay
	}
}