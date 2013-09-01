package com.slc.games.history.views {

	import com.slc.events.GeneralButtonEvent;
	import com.slc.events.ViewEvent;
	import com.slc.games.history.controller.IHistoryController;
	import com.slc.games.history.events.HistoryControllerEvent;
	import com.slc.games.history.events.HistoryViewEvent;
	import com.slc.games.history.model.HistoryModel;
	import com.slc.games.history.views.components.accounthistory.AccountHistory;
	import com.slc.games.history.views.components.baccarat.Baccarat;
	import com.slc.games.history.views.components.blackjack.Blackjack;
	import com.slc.games.history.views.components.dayactivity.DayActivity;
	import com.slc.games.history.views.components.roulette.Roulette;
	import com.slc.games.history.views.components.transaction.Transaction;
	import com.slc.ui.Language;
	import com.slc.ui.Style;
	import com.slc.ui.buttons.GeneralButton;
	import com.slc.ui.buttons.IGeneralButton;
	import com.slc.ui.text.IText;
	import com.slc.ui.text.Text;
	import com.slc.ui.views.BaseView;
	import com.slc.ui.views.IBaseView;
	import com.slc.ui.views.components.IBaseComponentView;
	import com.slc.utilities.StyleUtils;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.text.TextField;

	/**
	 * The main view for the History component, containing all other views.
	 * Is responsible for managing which of those views is shown and
	 * initialising them with data.
	 *
	 * @author Elliot Harris
	 */
	public class HistoryView extends BaseView {
		protected var _model:HistoryModel;
		protected var _controller:IHistoryController;

		protected var _title:IText;
		protected var _headerFill:Sprite;
		public var _close:IGeneralButton;
		protected var _headerButton:IGeneralButton;
		protected var _backgroundFill:Sprite;

		//sub views
		protected var _views:Array = new Array();
		protected var _loading:IBaseView;
		protected var _currentDayActivity:IBaseComponentView;
		protected var _selectedDayActivity:IBaseComponentView;
		protected var _accountHistory:IBaseComponentView;
		protected var _transaction:IBaseComponentView;
		protected var _roulette:IBaseComponentView;
		protected var _baccarat:IBaseComponentView;
		protected var _blackjack:IBaseComponentView;

		protected var _currentView:String;
		protected var _nextView:String;
		protected var _lastView:String;

		public function HistoryView(target:Sprite, model:HistoryModel, controller:IHistoryController) {
			super(target);
			_model = model;
			_controller = controller;
		}

		protected function addEventListeners():void {
			_target.addEventListener(HistoryViewEvent.CURRENT_ACTIVITY_CLICK, onCurrentActivityClick);
			_target.addEventListener(HistoryViewEvent.ACCOUNT_HISTORY_CLICK, onAccountHistoryClick);
			_target.addEventListener(ViewEvent.BACK_CLICK, onBackClick);
			_target.addEventListener(HistoryViewEvent.DAY_ITEM_CLICK, onDayItemClick);
			_target.addEventListener(HistoryViewEvent.TRANSACTION_CLICK, onTransactionClick);
			_target.addEventListener(HistoryViewEvent.GAME_CLICK, onGameClick);
		}

		/**
		 * Invoked when a game is selected from the day views.
		 */
		protected function onGameClick(e:HistoryViewEvent):void {
			var viewString:String;
			if (e.gameLabel == _model.ROULETTE_LABEL) {
				viewString = _model.ROULETTE;
				if (e.gameId != _model.lastRouletteGameId) {
					_model.gameXML = null;
					_roulette.isInitialised = false;
				}
			}
			else if (e.gameLabel == _model.BACCARAT_LABEL) {
				viewString = _model.BACCARAT;
				if (e.gameId != _model.lastBaccaratGameId) {
					_model.gameXML = null;
					_baccarat.isInitialised = false;
				}
			}
			else //Can assume blackjack, but the following is safer: else if(e.gameLabel == _model.BLACKJACK_LABEL)
			{
				viewString = _model.BLACKJACK;
				if (e.gameId != _model.lastBlackjackGameId) {
					_model.gameXML = null;
					_blackjack.isInitialised = false;
				}
			}

			showView(viewString, null, e.gameId, e.gameLabel);
		}

		protected function onTransactionClick(e:HistoryViewEvent):void {
			if (e.gameId != _model.lastTransactionGameId) {
				_model.transactionXML = null;
				_model.lastTransactionGameId = e.gameId;
				_transaction.isInitialised = false;
			}
			showView(_model.TRANSACTION, null, e.gameId, e.gameLabel);
		}

		protected function onDayItemClick(e:HistoryViewEvent):void {
			if (e.selectedDay != _model.lastSelectedDay) {
				_model.selectedDayActivtyXML = null;
				_model.lastSelectedDay = e.selectedDay;
				_selectedDayActivity.isInitialised = false;
			}
			showView(_model.SELECTED_DAY_ACTIVITY, e.selectedDay);
		}

		protected function onAccountHistoryClick(e:HistoryViewEvent):void {
			showView(_model.ACCOUNT_HISTORY);
		}

		protected function onCurrentActivityClick(e:HistoryViewEvent):void {
			showView(_model.CURRENT_DAY_ACTIVITY);
		}

		protected function onBackClick(e:ViewEvent):void {
			showView(_lastView);
		}

		protected function onCloseClick(e:GeneralButtonEvent):void {
			dispatchEvent(new ViewEvent(ViewEvent.CLOSE_CLICK));
		}

		protected function onHeaderMouseDown(e:GeneralButtonEvent):void {
			Sprite(_target.parent).startDrag();
		}

		protected function onHeaderMouseUp(e:GeneralButtonEvent):void {
			Sprite(_target.parent).stopDrag();
		}

		/**
		 * Invoked when the controller has completed loading the requested
		 * view XML. At that point the controller listener is removed
		 * and the view which was waiting for the XML to load is now shown.
		 */
		protected function onViewXMLComplete(e:HistoryControllerEvent):void {
			_controller.removeEventListener(HistoryControllerEvent.VIEW_XML_COMPLETE, onViewXMLComplete)
			showView(_nextView);
		}

		protected function hideAllViews():void {
			for each (var v:IBaseView in _views) {
				v.visible = false;
			}
		}

		/**
		 * Shows the requested view if it has either been initialised or if it
		 * has not been initialised but has its data waiting to passed in from
		 * the model. If neither of those is true, the controller is asked to
		 * load the correct XML data and the name of the requested view is
		 * saved for reference once the data load is complete.
		 *
		 * @param viewString The view to be shown
		 * @param selectedDay Inidicates which day's XML should be loaded (optional)
		 * @param gameId Indicates which particular game should be loaded (optional)
		 */
		public function showView(viewString:String, selectedDay:String = null, gameId:String = null, gameLabel:String = null):void {
			updateTitle();
			if (viewString != _currentView) {
				hideAllViews();

				//Ensure you set the success var to true in the switch statement
				//if the view is successfully displayed (it is either initialised, 
				//or the XML has been passed to it, which in turn will result it 
				//being initialised)
				var success:Boolean = false;

				trace("HISTORY VIEW :" + success);

				switch (viewString) {
					/*
					 * Each if these case statements determins whether or not the requested
					 * view is initialised, or if its data is loaded. In either case, the
					 * success var is set to true. If not, the success var is left as false.
					 */
					case _model.CURRENT_DAY_ACTIVITY:
						if (_currentDayActivity.isInitialised) {
							_currentDayActivity.visible = success = true;
						}
						else if (_model.currentDayActivityXML) {
							_currentDayActivity.parseXML(_model.currentDayActivityXML);
							_currentDayActivity.visible = success = true;
						}
						break;
					case _model.ACCOUNT_HISTORY:
						if (_accountHistory.isInitialised) {
							_accountHistory.visible = success = true;
						}
						else if (_model.accountHistoryXML) {
							_accountHistory.parseXML(_model.accountHistoryXML);
							_accountHistory.visible = success = true;
						}
						break;
					case _model.SELECTED_DAY_ACTIVITY:
						if (_selectedDayActivity.isInitialised) {
							_selectedDayActivity.visible = success = true;
						}
						else if (_model.selectedDayActivtyXML) {
							_selectedDayActivity.parseXML(_model.selectedDayActivtyXML);
							_selectedDayActivity.visible = success = true;
						}
						break;
					case _model.TRANSACTION:
						if (_transaction.isInitialised) {
							_transaction.visible = success = true;
						}
						else if (_model.transactionXML) {
							_transaction.parseXML(_model.transactionXML);
							_transaction.visible = success = true;
						}
						break;
					case _model.ROULETTE:
						if (_roulette.isInitialised) {
							_roulette.visible = success = true;
						}
						else if (_model.gameXML) {
							_roulette.parseXML(_model.gameXML);
							_roulette.visible = success = true;
						}
						updateTitle("roulette");
						break;
					case _model.BACCARAT:
						if (_baccarat.isInitialised) {
							_baccarat.visible = success = true;
						}
						else if (_model.gameXML) {
							_baccarat.parseXML(_model.gameXML);
							_baccarat.visible = success = true;
						}
						updateTitle("baccarat");
						break;
					case _model.BLACKJACK:
						if (_blackjack.isInitialised) {
							_blackjack.visible = success = true;
						}
						else if (_model.gameXML) {
							_blackjack.parseXML(_model.gameXML);
							_blackjack.visible = success = true;
						}
						updateTitle("blackjack");
						break;
					case _model.LOADING:
						_loading.visible = success = true;
						break;
				}

				if (!success) //load the xml for the desired view
				{
					reloadData(viewString, selectedDay, gameId, gameLabel);
				}
				else {
					if (_currentView != _model.LOADING) {
						_lastView = _currentView;
					}
					_currentView = viewString;
				}

				trace("HISTORY VIEW AFRER:" + success);
			}
		}

		public function reloadData(viewString:String, selectedDay:String = null, gameId:String = null, gameLabel:String = null):void {
			showView(_model.LOADING);
			_nextView = viewString;
			_controller.addEventListener(HistoryControllerEvent.VIEW_XML_COMPLETE, onViewXMLComplete)
			_controller.loadViewXML(viewString, selectedDay, gameId, gameLabel);
			_currentDayActivity.isInitialised = false;
		}

		public function disableBack(game:String):void {
			switch (game) {
				case "roulette":
					_roulette.back = false;
					break;
				case "baccarat":
					_baccarat.back = false;
					break;
				case "blackjack":
					_blackjack.back = false;
					break;
			}
		}

		public function updateTitle(substr:String = null):void {
			_title.text = Language.getInstance().getProperty("historytitle").toUpperCase();
			if (substr != null) {
				_title.text += " - " + Language.getInstance().getProperty(substr);
			}
			if (_model.game != null && _model.gameId != null) {
				_title.text += " (" + Language.getInstance().getProperty("historylastgame") + ")";
			}
		}

		/**
		 * Initialises the sub views and styles the main elements.
		 */
		public function init():void {
			//Title text
			_title = new Text(_target.getChildByName("title") as TextField);
			updateTitle();
			_title.style = "historyTitleTxt";

			//Fill colour(s) behind the title text
			_headerFill = _target.getChildByName("headerFill") as Sprite;
			StyleUtils.createGradient(_headerFill, Style.getInstance().getPropertyAsColor("historyHeaderBg1"), Style.getInstance().getPropertyAsColor("historyHeaderBg2"), 540, 25);

			//Fill colour(s) used as the background for the component
			_backgroundFill = _target.getChildByName("backgroundFill") as Sprite;
			StyleUtils.createGradient(_backgroundFill, Style.getInstance().getPropertyAsColor("historyBgColor1"), Style.getInstance().getPropertyAsColor("historyBgColor2"), 550, 360);

			//Header drag button
			var m:MovieClip = new MovieClip();
			m.graphics.beginFill(0, 0);
			m.graphics.drawRoundRect(_headerFill.x, _headerFill.y, _headerFill.width, _headerFill.height, 5, 5);
			_target.addChild(m);

			//Close button
			_close = new GeneralButton(_target.getChildByName("close") as MovieClip, 0);
			_target.addChild(_close.target); //Puts the close button on top
			_close.addEventListener(GeneralButtonEvent.CLICK, onCloseClick);
			
			var newColorTransform:ColorTransform = _close.target.transform.colorTransform;
			newColorTransform.color = (Style.getInstance().getProperty("closeBtnColor") != null) ? Style.getInstance().getPropertyAsColor("closeBtnColor") : 0xFFFFFF;
			_close.target.transform.colorTransform = newColorTransform;

			//Loading view
			_loading = new BaseView(_target.getChildByName("loading") as Sprite);
			_views.push(_loading);

			//Current Activity view
			_currentDayActivity = new DayActivity(_target.getChildByName("currentDayActivity") as Sprite);
			_views.push(_currentDayActivity);

			//Selected Day Activity view
			_selectedDayActivity = new DayActivity(_target.getChildByName("selectedDayActivity") as Sprite);
			_views.push(_selectedDayActivity);

			//Account History view
			_accountHistory = new AccountHistory(_target.getChildByName("accountHistory") as Sprite);
			_views.push(_accountHistory);

			//Transaction view
			_transaction = new Transaction(_target.getChildByName("transaction") as Sprite);
			_views.push(_transaction);

			//Roulette view
			_roulette = new Roulette(_target.getChildByName("roulette") as Sprite);
			_views.push(_roulette);

			//Baccart view
			_baccarat = new Baccarat(_target.getChildByName("baccarat") as Sprite);
			_views.push(_baccarat);

			//Blackjack view
			_blackjack = new Blackjack(_target.getChildByName("blackjack") as Sprite);
			_views.push(_blackjack);

			addEventListeners(); //for events from sub-views
		}
	}

}

