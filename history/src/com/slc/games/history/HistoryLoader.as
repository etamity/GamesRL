package com.slc.games.history {

	import com.loading.BulkLoader;
	import com.loading.BulkProgressEvent;
	import com.slc.utilities.*;
	import com.slc.ui.*;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.LocalConnection;
	import flash.events.MouseEvent;
	import flash.system.LoaderContext;
	import flash.events.Event;

	/**
	 * History component.
	 * @author Elliot Harris
	 */
	[SWF(width = "550", height = "360", frameRate = "30", pageTitle = "History", backgroundColor = "#000000")]
	public class HistoryLoader extends MovieClip {
		private var lc:LocalConnection = new LocalConnection();
		private var _historyURLS:String;
		private var gameHistoryLoader:BulkLoader;
		private var gameHistorySWF:MovieClip;
		private var historyGame:String;
		private var historyGameID:String;
		private var loaderContext:LoaderContext;
		private var assetLoader:BulkLoader;
		private var user_id:String;

		public function HistoryLoader() {
			_historyURLS = "/player/games/history/History.swf";
			assetLoader = new BulkLoader("HistoryLoader");

			gameHistoryLoader = new BulkLoader("gamehistorySWF");

			user_id = WebUtils.Request("userid");
			GlobalConfig.LANGUAGE = WebUtils.Request("lang");
			GlobalConfig.LANGUAGE_PATH = "/player/games/languages/" + GlobalConfig.LANGUAGE + ".xml";
			GlobalConfig.AAMS = false;
			assetLoader.add(GlobalConfig.LANGUAGE_PATH, {"id": "language", type: "XML", preventCache: GlobalConfig.NO_CACHE});
			assetLoader.addEventListener(BulkProgressEvent.COMPLETE, languageLoaded);
			assetLoader.addEventListener(BulkLoader.ERROR, handleGenericLoaderIOError);
			assetLoader.start();
			loadHistorySWF();
			Debug.log("[LOBBY] LOADING HISTORY: " + _historyURLS);
			Debug.log("[LOBBY] userid: " + user_id);
		}

		private function handleGenericLoaderIOError(evt:Event):void {
			Debug.log("[LOBBY] LOADER ERROR: " + evt);
		}

		private function languageLoaded(evt:BulkProgressEvent):void {
			assetLoader.removeEventListener(BulkProgressEvent.COMPLETE, languageLoaded);
			Language.getInstance().xml = assetLoader.getXML("language");
		}

		private function showHistorySWF(evt:BulkProgressEvent):void {
			gameHistorySWF = gameHistoryLoader.getMovieClip("gamehistory");
			addChild(gameHistorySWF);
			gameHistorySWF.init(user_id, true);
			gameHistorySWF.x = 0;
			gameHistorySWF.y = 0;
			gameHistorySWF.visible = true;
		}

		public function loadHistorySWF(game:String = null, gameid:String = null):void {
			if (!gameHistoryLoader.hasItem("gamehistory")) {
				Debug.log("[LOBBY] LOADING HISTORY: " + _historyURLS);
				gameHistoryLoader.add(_historyURLS, {"id": "gamehistory", context: loaderContext});
				gameHistoryLoader.addEventListener(BulkProgressEvent.COMPLETE, showGameHistory);
				gameHistoryLoader.start();
			}
			else {
				gameHistorySWF.visible = true;
				gameHistorySWF.init(user_id, false);
			}
			historyGame = game;
			historyGameID = gameid;
		}

		private function showGameHistory(evt:BulkProgressEvent):void {
			Debug.log("[LOBBY] SHOWING HISTORY");
			gameHistorySWF = gameHistoryLoader.getMovieClip("gamehistory");
			addChild(gameHistorySWF);
			gameHistorySWF.x = 0;
			gameHistorySWF.y = 0;
			if (historyGame != null && historyGameID != null) {
				gameHistorySWF.init(user_id, true, historyGame, historyGameID);
				historyGame = null;
				historyGameID = null;
			}
			else {
				gameHistorySWF.init(user_id, true);
			}
		}
	}
}

