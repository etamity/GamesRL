package com.slc.games.history.controller {

	import com.slc.events.XMLLoaderEvent;
	import com.slc.games.history.events.HistoryControllerEvent;
	import com.slc.games.history.model.HistoryModel;
	import com.slc.utilities.*;

	import flash.events.EventDispatcher;

	/**
	 * Manages data loading and model manipulation.
	 *
	 * @author Elliot Harris
	 */
	public class HistoryController extends EventDispatcher implements IHistoryController {
		protected var _model:HistoryModel;

		protected var _xmlLoader:XMLLoader;

		protected var _viewLoading:String;

		public function HistoryController(model:HistoryModel) {
			_model = model;
			_xmlLoader = new XMLLoader();
			_xmlLoader.addEventListener(XMLLoaderEvent.COMPLETE, onXMLLoaderComplete);
		}

		/**
		 * Saves the XML to the model once it has been loaded, then dispatches an
		 * event to inform the History View that loading has completed.
		 */
		protected function onXMLLoaderComplete(e:XMLLoaderEvent):void {
			switch (_viewLoading) {
				case _model.CURRENT_DAY_ACTIVITY:
					_model.currentDayActivityXML = e.xml;
					break;
				case _model.ACCOUNT_HISTORY:
					_model.accountHistoryXML = e.xml;
					break;
				case _model.SELECTED_DAY_ACTIVITY:
					_model.selectedDayActivtyXML = e.xml;
					break;
				case _model.TRANSACTION:
					_model.transactionXML = e.xml;
					break;
				case _model.ROULETTE:
				case _model.BLACKJACK:
				case _model.BACCARAT:
					_model.gameXML = e.xml;
					break;
			}
			Debug.log("HISTORY RESPONSE: " + e.xml);
			dispatchEvent(new HistoryControllerEvent(HistoryControllerEvent.VIEW_XML_COMPLETE));
		}

		/**
		 * Loads the correct XML for any given view. Takes some optional parameters that
		 * may be necessary depending on which view XML needs to be loaded.
		 *
		 * @param viewString The view whose XML should be loaded
		 * @param selectedDay Inidicates which day's XML should be loaded (optional)
		 * @param gameId Indicates which particular game should be loaded (optional)
		 */
		public function loadViewXML(viewString:String, selectedDay:String = null, gameId:String = null, gameLabel:String = null):void {
			var xmlURL:String;
			switch (viewString) {
				case _model.CURRENT_DAY_ACTIVITY:
					xmlURL = _model.currentDayActivityURL + "?user_id=" + _model.userId;
					break;
				case _model.ACCOUNT_HISTORY:
					xmlURL = _model.accountHistoryURL + "?user_id=" + _model.userId;
					break;
				case _model.SELECTED_DAY_ACTIVITY:
					xmlURL = _model.selectedDayActivityURL + "?user_id=" + _model.userId + "&date=" + selectedDay;
					break;
				case _model.TRANSACTION:
					xmlURL = _model.transactionURL + "?user_id=" + _model.userId + "&transaction_id=" + gameId;
					break;
				case _model.ROULETTE:
				case _model.BLACKJACK:
				case _model.BACCARAT:
					xmlURL = _model.gameURL + "?user_id=" + _model.userId + "&game_id=" + gameId + "&game=" + gameLabel.toLowerCase();
					break;
			}
			//load xml
			_viewLoading = viewString;
			xmlURL += "&r=" + Math.random() + Math.random();
			Debug.log("HISTORY CALL: " + xmlURL);
			_xmlLoader.loadXML(xmlURL);
		}

		/**
		 * Closes the component.
		 */
		public function close():void {
			/*
			 * Set all the XML properties in the model to null, forcing
			 * them to reload next time. Note that the selectedDayXML is
			 * not nullified here, in case the user loads the history
			 * panel again and requests the data for the same date again
			 * immediately, when there would be no need to reload the data.
			 */
			_model.currentDayActivityXML = null;
			_model.accountHistoryXML = null;
			_model.transactionXML = null;
		}
	}

}

