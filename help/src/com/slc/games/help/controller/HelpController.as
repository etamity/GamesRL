package com.slc.games.help.controller {

	import com.slc.events.XMLLoaderEvent;
	import com.slc.games.help.events.HelpControllerEvent;
	import com.slc.games.help.model.HelpModel;
	import com.slc.utilities.*;

	import flash.events.EventDispatcher;

	public class HelpController extends EventDispatcher implements IHelpController {
		protected var _model:HelpModel;

		protected var _xmlLoader:XMLLoader;

		protected var _helpPageIndex:uint;

		public function HelpController(model:HelpModel) {
			_model = model;
			_xmlLoader = new XMLLoader();
		}

		/**
		 * Saves the main XML to the model once it has been loaded, then dispatches an
		 * event to inform the Help View that loading has completed.
		 */
		protected function onMainXMLComplete(e:XMLLoaderEvent):void {
			_model.helpXML = e.xml;
			var items:XMLList = e.xml.item;
			_model.helpPages = new Array(items.length());
			dispatchEvent(new HelpControllerEvent(HelpControllerEvent.XML_COMPLETE));
		}

		/**
		 * Saves the Help Page XML to the model once it has been loaded, then
		 * dispatches an event to inform the Help View that loading has completed.
		 */
		protected function onHelpPageXMLComplete(e:XMLLoaderEvent):void {
			_model.helpPages[_helpPageIndex] = e.xml;
			dispatchEvent(new HelpControllerEvent(HelpControllerEvent.HELP_PAGE_COMPLETE));
		}

		/**
		 * Loads the XML for the statistics view.
		 */
		public function loadXML():void {
			var url:String = _model.helpURLs.child(_model.helpId);
			Debug.log("help call: " + url);
			_xmlLoader.removeEventListener(XMLLoaderEvent.COMPLETE, onHelpPageXMLComplete);
			_xmlLoader.addEventListener(XMLLoaderEvent.COMPLETE, onMainXMLComplete);
			_xmlLoader.loadXML(url);
		}

		/**
		 * Closes the component.
		 */
		public function close():void {
			//Nothing happens in the help component when it is closed.
		}

		public function loadHelpPage(index:uint):void {
			_helpPageIndex = index;
			var items:XMLList = _model.helpXML.item;
			var url:String    = items[index].content;
			Debug.log("help call: " + url);
			_xmlLoader.removeEventListener(XMLLoaderEvent.COMPLETE, onMainXMLComplete);
			_xmlLoader.addEventListener(XMLLoaderEvent.COMPLETE, onHelpPageXMLComplete);
			_xmlLoader.loadXML(url);
		}
	}
}

