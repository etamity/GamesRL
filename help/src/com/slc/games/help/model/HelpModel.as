package com.slc.games.help.model {

	public class HelpModel {
		private var _helpURLs:XML =
			<urls>
				<help1>xml/helpXML.xml</help1>
			</urls>
			;
		private var _helpXML:XML;
		private var _helpId:String;
		private var _helpTitle:String;

		private var _helpPages:Array;

		public function HelpModel() {

		}

		//URL
		public function get helpURLs():XML {
			return _helpURLs;
		}

		public function set helpURLs(v:XML):void {
			_helpURLs = v;
		}

		//Query string value added to the URL
		public function get helpId():String {
			return _helpId;
		}

		public function set helpId(v:String):void {
			_helpId = v;
		}

		//XML
		public function get helpXML():XML {
			return _helpXML;
		}

		public function set helpXML(v:XML):void {
			_helpXML = v;
		}

		//The title to be displayed in the Help view
		public function get helpTitle():String {
			return _helpTitle;
		}

		public function set helpTitle(v:String):void {
			_helpTitle = v;
		}

		//Content of the help pages
		public function get helpPages():Array {
			return _helpPages;
		}

		public function set helpPages(v:Array):void {
			_helpPages = v;
		}
	}
}

