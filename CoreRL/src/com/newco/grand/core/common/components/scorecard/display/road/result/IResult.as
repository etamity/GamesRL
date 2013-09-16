package com.newco.grand.core.common.components.scorecard.display.road.result {
	
	import com.newco.grand.core.common.view.ui.views.IBaseView;
	
	public interface IResult extends IBaseView {
		function get type():String
		function setTypes(type:String, tieType:String=null):void
		function set score(v:uint):void
		function get userType():String //player or banker only		
	}
}