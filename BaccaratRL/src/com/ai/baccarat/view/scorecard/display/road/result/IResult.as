package com.ai.baccarat.view.scorecard.display.road.result {
	
	import com.ai.core.view.ui.views.IBaseView;
	
	public interface IResult extends IBaseView {
		function get type():String
		function setTypes(type:String, tieType:String=null):void
		function set score(v:uint):void
		function get userType():String //player or banker only		
	}
}