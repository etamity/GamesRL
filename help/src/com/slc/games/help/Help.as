package com.slc.games.help {

	import com.slc.events.ViewEvent;
	import com.slc.events.XMLLoaderEvent;
	import com.slc.games.help.controller.HelpController;
	import com.slc.games.help.controller.IHelpController;
	import com.slc.games.help.model.HelpModel;
	import com.slc.games.help.views.HelpView;
	import com.slc.utilities.Debug;
	import com.slc.utilities.GlobalConfig;
	import com.slc.utilities.XMLLoader;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.net.LocalConnection;

	[SWF(width = "550", height = "360", frameRate = "24", backgroundColor = "#000000")]
	public class Help extends MovieClip implements IHelp {
		private var lc:LocalConnection         = new LocalConnection();
		protected var _controller:IHelpController;
		protected var _model:HelpModel;
		protected var _xmlLoader:XMLLoader;
		private var _helpURLS:String;

		protected var _loadHelpXMLFlag:Boolean = false;

		public function Help() {
			_model = new HelpModel();
			_xmlLoader = new XMLLoader();
			_helpURLS = "/player/games/help/helpurls_" + GlobalConfig.LANGUAGE + ".xml";
			init();
		}

		protected function onCloseClick(e:ViewEvent):void {
			visible = false;
		}

		protected function onXMLComplete(e:XMLLoaderEvent):void {
			_model.helpURLs = e.xml;
			build();
			if (_loadHelpXMLFlag) {
				loadHelp(_model.helpId, _model.helpTitle);
			}
		}

		protected function build():void {
			_controller = new HelpController(_model);

			var target:Sprite = addChild(new HelpInterface()) as Sprite;
			var v:HelpView    = new HelpView(target, _model, _controller);
			v.init();
			if (parent.name == "container") {
				v._close.visible = false;
			}

			v.addEventListener(ViewEvent.CLOSE_CLICK, onCloseClick);
			visible = true;
		}

		/**
		 * Intialises and displays the component, including the loading of XML.
		 *
		 * <p>The loadURLXML Boolean determins whether or not the XML containing
		 * the correct URLs for the server calls is loaded.Note that if this isn't
		 * loaded, the paths may be set through the model property of this class.
		 * If you ask the URL XML to be loaded, and loading fails, this component
		 * will fail to initialise.</p>
		 *
		 * @param loadURLXML Indicates whether to load the XML containing the
		 * appropriate URLs
		 */
		public function init(loadURLXML:Boolean = true):void {
			if (lc.domain == "localhost") {
				_helpURLS = "xml/helpurls_en.xml";
			}
			if (loadURLXML) {
				_xmlLoader.addEventListener(XMLLoaderEvent.COMPLETE, onXMLComplete);
				_xmlLoader.loadXML(_helpURLS);
			}
			else {
				build();
			}
			if (lc.domain == "localhost") {
				loadHelp("lobby", "Lobby");
			}
		}

		/**
		 * Loads the help contents document at the url specified by
		 * _model.helpURL, using helpId as a query string. The title
		 * of the resulting help window is also passed in here.
		 *
		 * @param helpId A value used to determin to specify which
		 * url within the helpURLs document to use in order to retrieve
		 * the correct help document
		 * @param helpTitle The title to be displayed at the top of the
		 * window.
		 */
		public function loadHelp(helpId:String, helpTitle:String = ""):void {
			_model.helpId = helpId;
			_model.helpTitle = helpTitle;

			if (!_xmlLoader.isLoading) {
				_controller.loadXML();
			}
			else {
				_loadHelpXMLFlag = true;
			}
		}

		public function get model():HelpModel {
			return _model;
		}

		public function localhost():void {
			if (lc.domain == "localhost") {
				_helpURLS = "xml/helpurls_en.xml";
				init(true);
				loadHelp("lobby", "Lobby");
			}
		}
	}
}
