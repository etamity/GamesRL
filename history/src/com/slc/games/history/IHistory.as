package com.slc.games.history {

	import com.slc.games.history.model.HistoryModel;

	public interface IHistory {
		function init(userId:String = null, loadURLXML:Boolean = true, game:String = null, gameId:String = null):void
		function set visible(v:Boolean):void
		function get model():HistoryModel
	}
}

