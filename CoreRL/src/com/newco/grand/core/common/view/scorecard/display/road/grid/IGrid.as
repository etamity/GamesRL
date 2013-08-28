package com.newco.grand.core.common.view.scorecard.display.road.grid {
	
	import com.newco.grand.core.common.view.scorecard.display.road.result.IResult;
	import com.newco.grand.core.common.view.ui.views.IBaseView;

	public interface IGrid extends IBaseView {
		function addToColumn(result:IResult, columnIndex:uint):void
		function addToGridAt(result:IResult, xPos:uint, yPos:uint):void
		function getResultAt(xPos:uint, yPos:uint):IResult
		function clear():void
		function set vSpacing(v:Number):void
		function set hSpacing(v:Number):void
		function set vPadding(v:Number):void
		function set hPadding(v:Number):void
	}
}