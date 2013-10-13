package  {

	import com.slc.events.ViewEvent;
	import com.slc.events.XMLLoaderEvent;
	import com.slc.games.history.IHistory;
	import com.slc.games.history.controller.HistoryController;
	import com.slc.games.history.controller.IHistoryController;
	import com.slc.games.history.model.HistoryModel;
	import com.slc.games.history.views.HistoryView;
	import com.slc.utilities.Debug;
	import com.slc.utilities.XMLLoader;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.LocalConnection;

	/**
	 * History component.
	 * @author Elliot Harris
	 */
	[SWF(width = "550", height = "360", frameRate = "30", pageTitle = "History", backgroundColor = "#000000")]
	public class History extends MovieClip implements IHistory {
		private var lc:LocalConnection = new LocalConnection();
		protected var _controller:IHistoryController;
		protected var _model:HistoryModel;
		protected var _view:HistoryView;
		protected var _xmlLoader:XMLLoader;
		private var _historyURLS:String;
        
		public function hideCloseButton():void{
			_view._close.visible = false;
		}
		
		public function History() {
			_model = new HistoryModel();
			_xmlLoader = new XMLLoader();
			_historyURLS = "/player/audit/getHistoryUrls.jsp";
			addChild(new preloader());
			this.addEventListener(Event.ADDED_TO_STAGE,onAddtoStage);
		}
		private function onAddtoStage(evt:Event):void{
			if (stage.loaderInfo.parameters.server!=null)
			{
				var server:String=stage.loaderInfo.parameters.server;
				_historyURLS = server+"/player/audit/getHistoryUrls.jsp";
				//init();
			}
		}
		protected function onCloseClick(e:ViewEvent):void {
			visible = false;
		}

		protected function onXMLComplete(e:XMLLoaderEvent):void {
			Debug.log("HISTORY URLS:" + e.xml);
			_model.currentDayActivityURL = e.xml.currentday;
			_model.selectedDayActivityURL = e.xml.selectedday;
			_model.accountHistoryURL = e.xml.history;
			_model.transactionURL = e.xml.transaction;
			_model.gameURL = e.xml.game;
			build();
		}

		protected function build():void {
			_controller = new HistoryController(_model);
			var target:Sprite = addChild(new HistoryInterface()) as Sprite;
			_view = new HistoryView(target, _model, _controller);
			_view.init();
			if (parent.name == "root2") {
				_view._close.visible = false;
			}
			_view.addEventListener(ViewEvent.CLOSE_CLICK, onCloseClick);

			if (_model.game != null && _model.gameId != null) {
				_view.showView(_model.game, null, _model.gameId, _model.game);
				_view.disableBack(_model.game);
			}
			else {
				_view.showView(_model.CURRENT_DAY_ACTIVITY);
				_model.game = null;
				_model.gameId = null;
			}
		}

		public function init(userId:String = null, loadURLXML:Boolean = true, game:String = null, gameId:String = null):void {
			if (lc.domain == "localhost") {
				_historyURLS = "xml/historyurls.xml";
			}
			_model.userId = userId;
			_model.gameId = gameId;
			_model.game = game;
			if (loadURLXML) {
				_xmlLoader.addEventListener(XMLLoaderEvent.COMPLETE, onXMLComplete);
				_xmlLoader.loadXML(_historyURLS);
				Debug.log("LOADING HISTORY URLS: " + _historyURLS);
			}
			else {
				_view.reloadData(_model.CURRENT_DAY_ACTIVITY);
				_model.game = null;
				_model.gameId = null;
			}
		}

		override public function set visible(v:Boolean):void {
			if (super.visible != v) {
				if (!v) {
					_controller.close();
				}
				else {
					_view.showView(_model.CURRENT_DAY_ACTIVITY);
				}
				super.visible = v;
			}
		}

		public function get model():HistoryModel {
			return _model;
		}

	}
}

