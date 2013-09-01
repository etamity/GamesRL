package com.slc.games.history.controller {

	import flash.events.IEventDispatcher;

	/**
	 * ...
	 * @author Elliot Harris
	 */
	public interface IHistoryController extends IEventDispatcher {
		function loadViewXML(viewString:String, selectedDate:String = null, gameId:String = null, gameLabel:String = null):void
		function close():void
	}

}

