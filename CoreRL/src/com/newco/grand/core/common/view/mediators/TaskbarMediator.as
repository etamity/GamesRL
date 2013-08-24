package com.newco.grand.core.common.view.mediators
{

	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.TaskbarActionEvent;
	import com.newco.grand.core.common.controller.signals.TooltipEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.GameState;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.Language;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.Style;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.view.interfaces.ITaskbarView;
	import com.newco.grand.core.utils.FormatUtils;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.SWFLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;

	public class TaskbarMediator extends Mediator
	{

		[Inject]
		public var view:ITaskbarView;

		[Inject]
		public var player:Player;

		[Inject]
		public var flashVars:FlashVars;

		[Inject]
		public var game:IGameData;

		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;
		
		[Inject]
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		
		public var GAMELOBBY:String="GAMELOBBY";
		
		private var lobbyMC:MovieClip;
		override public function initialize():void
		{

			signalBus.add(ModelReadyEvent.READY,setupModel);
			signalBus.add(SocketDataEvent.HANDLE_TIMER,checkBettingState);
			signalBus.add(BalanceEvent.LOADED,setBalance);
			signalBus.add(SocketDataEvent.HANDLE_GAME,setGameTime);
			signalBus.add(StateTableConfigEvent.LOADED,setChips);
			signalBus.add(BetEvent.TOTAL_BET,updateBet);
			signalBus.add(BetEvent.CLOSE_BETS,disableButtons);
		}

		private function setupModel(signal:BaseSignal):void
		{
			view.init();
			createMenuBar();
			addViewListeners();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
		
		}

		private function addViewListeners():void
		{

			/*view.chipClickedSignal.add(onChipClicked);
			view.buttonClickedSignal.add(buttonAction);
			view.menuitemClickedSignal.add(menuItemClicked);
			view.showDefaultSignal.add(showTooltip);
			view.undoSignal.add(betButtonAction);
			view.clearClickedSignal.add(betButtonAction);
			view.repeatClickedSignal.add(betButtonAction);
			view.doubleClickedSignal.add(betButtonAction);
			view.confirmClickedSignal.add(betButtonAction);
			view.favouritesClickedSignal.add(betButtonAction);*/
			
			view.signalBus.add(TaskbarActionEvent.BUTTON_CLICKED, buttonAction);
			view.signalBus.add(TaskbarActionEvent.MENUITEM_CLICKED, menuItemClicked);
			view.signalBus.add(TooltipEvent.SHOW_DEFAULT, showTooltip);
			view.signalBus.add(BetEvent.UNDO, betButtonAction);
			view.signalBus.add(BetEvent.CLEAR, betButtonAction);
			view.signalBus.add(BetEvent.REPEAT, betButtonAction);
			view.signalBus.add(BetEvent.DOUBLE, betButtonAction);
			view.signalBus.add(BetEvent.CONFRIM, betButtonAction);
			view.signalBus.add(BetEvent.FAVOURITES, betButtonAction);
			view.signalBus.add(TaskbarActionEvent.CHIP_CLICKED, onChipClicked);
			view.signalBus.add(TaskbarActionEvent.LOBBY_CLICKED, launchLobby);
		}

		private function createMenuBar():void
		{
			/*var menuXML_realplay:XML = Style.XMLDATA.realplay[0];
			var mylabel:String = String(menuXML_realplay.@label).toLocaleUpperCase();
			GameUtils.log("[REALPLAY]: "+menuXML_realplay);
			if (mylabel!="" || mylabel!=null ){
				var myurl:String   = String(menuXML_realplay.@url);
				view.myaccountLabel = mylabel;
				view.myAccountURL = myurl;
				GameUtils.log("[MENUBAR_myurl]: "+myurl);
				var myAccountEnable:Boolean=(menuXML_realplay.@enable =="true")?true:false;
				var showtime:int=menuXML_realplay.@showtime;
				var hidetime:int=menuXML_realplay.@hidetime;
				var date:Date=new Date();
				if (myAccountEnable==true)
				{
					if ((date.hours>=showtime) &&(date.hours<=hidetime))
					{
						view.myAccountEnabled(true);
					}else
					{
						view.myAccountEnabled(false);
					}
				}
				else
				{
					view.myAccountEnabled(false);
				}

			}*/

			var menuXML:XML=new XML(Style['MENUBAR_XML']);
			for each (var node:XML in menuXML.children())
			{
				var label:String=Language[String(node.@label).toLocaleUpperCase()] || node.@label;
				var url:String=FormatUtils.formetURL(node.@url, {"{sessionId}": flashVars.sessionId, "{site}": flashVars.site, "{lang}": flashVars.lang});

				if (menuXML.children().length() == 1)
				{
					view.myaccountLabel=label;
					view.myAccountURL=url;
				}
				else
				{
					view.createMenuItem(label, url);
				}
			}
			view.myaccountLabel=String(menuXML.@label).toUpperCase();
			view.myAccountEnabled(false);

		}

		private function menuItemClicked(url:String):void
		{
			var newurl:String=url;
			if (ExternalInterface.available)
			{
				var param:String='propertyName=';
				var windowName:String=newurl.substr(newurl.lastIndexOf(param) + param.length, newurl.length);
				ExternalInterface.call("window.open", newurl, "PopUpWindow", "height=660,width=920;toolbar=yes,scrollbars=yes");
			}
			else
			{
				var URLReq:URLRequest=new URLRequest(newurl);
				navigateToURL(URLReq);
				navigateToURL(new URLRequest(newurl), "_blank");
			}
		}

		private function onChipClicked(signal:BaseSignal):void
		{
			game.chipSelected=view.chipSelected;
			//eventDispatcher.dispatchEvent(event);
			signalBus.dispatch(TaskbarActionEvent.CHIP_CLICKED);
		}
		private function launchLobby(signal:BaseSignal):void {
			/*if (lobbyMC == null) {
				service.add(GlobalConfig.LOBBY_SWF, {"id": "lobbyswf", context: loaderContext});
				lobbyLoader.addEventListener(BulkProgressEvent.COMPLETE, showLobby);
				lobbyLoader.start();
			}
			else {
				setupGameType();
			}
			tooltipMC.hideTip();
			*/
			if (lobbyMC == null) {
			service.addLoader(new SWFLoader(new URLRequest(urls.lobby), GAMELOBBY));
			service.getLoader(GAMELOBBY).onError.add(showError);
			service.getLoader(GAMELOBBY).onComplete.add(setConfig);			
			service.start();
			} else
			{
				lobbyMC.visible=true;
			}
		
			
		}
		private function setConfig(signal:LoaderSignal, mc:MovieClip):void {
			lobbyMC=mc;
			contextView.view.addChild(lobbyMC);
			
			lobbyMC.loadLobbyXML(flashVars.table_id,false);
			
			//lobbyMC.popupMC = GlobalConfig.POPUP_WINDOW;
			lobbyMC.close = true;
			lobbyMC.popup = false;
			lobbyMC.transparency = 0.8;
			lobbyMC.game="roulette";
			service.getLoader(GAMELOBBY).onComplete.remove(setConfig);
		}
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message + "::" +urls.lobby});
		}
	
		private function buttonAction(signal:BaseSignal):void
		{
			var type:String=signal.params.eventType;
			trace("type:",type);
			switch (type)
			{
				case TaskbarActionEvent.FULLSCREEN_CLICKED:
					signalBus.dispatch(TaskbarActionEvent.FULLSCREEN_CLICKED);
					break;
				case TaskbarActionEvent.HELP_CLICKED:
					//eventDispatcher.dispatchEvent(new TaskbarActionEvent(TaskbarActionEvent.HELP_CLICKED));
					signalBus.dispatch(TaskbarActionEvent.HELP_CLICKED);
					break;
				case TaskbarActionEvent.HISTORY_CLICKED:
					//eventDispatcher.dispatchEvent(new TaskbarActionEvent(TaskbarActionEvent.HISTORY_CLICKED));
					signalBus.dispatch(TaskbarActionEvent.HISTORY_CLICKED);
					break;
				case TaskbarActionEvent.SOUND_CLICKED:
					//eventDispatcher.dispatchEvent(new TaskbarActionEvent(TaskbarActionEvent.SOUND_CLICKED));
					signalBus.dispatch(TaskbarActionEvent.SOUND_CLICKED);
					break;
			}
		}

		private function showTooltip(signal:BaseSignal):void
		{
			var type:String=signal.type;
			var target:MovieClip=signal.params.target;
			switch (type)
			{
				case TaskbarActionEvent.FULLSCREEN_CLICKED:
					view.showTooltip(target, game.fullscreen ? Language.RESTORE : Language.FULLSCREEN);
					break;
				case TaskbarActionEvent.HELP_CLICKED:
					view.showTooltip(target, Language.HELP);
					break;
				case TaskbarActionEvent.HISTORY_CLICKED:
					view.showTooltip(target, Language.HISTORY);
					break;
				case TaskbarActionEvent.SOUND_CLICKED:
					view.showTooltip(target, game.sound ? Language.SOUNDON:Language.SOUNDOFF);
					break;
			}
		}

		private function betButtonAction(signal:BaseSignal):void
		{
			//eventDispatcher.dispatchEvent(event);
			signalBus.dispatch(signal.type);
			switch (signal.type) {
				case BetEvent.REPEAT:
					view.disbleRepeat();
					break;
				case BetEvent.DOUBLE:
					view.disbleRepeat();
					view.disbleDouble();
					break;
				case BetEvent.CONFRIM:
					view.enableFavourites();
					view.disbleClear();
					view.disbleConfirm();
					view.disbleUndo();
					view.disbleRepeat();
					view.disbleDouble();
					break;
				case BetEvent.FAVOURITES:
					view.disbleFavourites();
					break;
			}

			/*if (event.type == BetEvent.REPEAT)
			{
				view.disbleRepeat();
			}
			else if (event.type == BetEvent.DOUBLE)
			{
				view.disbleRepeat();
				view.disbleDouble();
			}
			*/
			

		}

		private function disableButtons(signal:BaseSignal):void
		{
			view.disableButtons();
			if (FlashVars.GAMECLIENT=="baccarat")
			 view.slideDownButtons();
		}

		private function setBalance(signal:BaseSignal):void
		{
			view.balance=player.balanceFormatted;
			view.bet=player.betFormatted;
		}

		private function setChips(signal:BaseSignal):void
		{
			view.chips=game.chips;
		}

		private function setGameTime(signal:BaseSignal):void
		{
			
			view.game=game.gameTime;
			checkForRepeatAndDouble();
			if (FlashVars.GAMECLIENT=="baccarat")
			view.slideUpButtons();
		}

		private function checkForRepeatAndDouble():void
		{
			debug("player.lastBet",player.lastBet);
			if (player.lastBet > 0)
			{
				if (player.lastBet <= player.balance)
				{
					view.enableRepeat();
				}
				if (player.lastBet * 2 <= player.balance)
				{
					view.enableDouble();
				}
			}
		}

		private function checkBettingState(signal:BaseSignal=null):void
		{
			view.enableChips();
		}

		private function updateBet(signal:BaseSignal):void
		{
			view.balance=player.bettingBalanceFormatted;
			view.bet=player.betFormatted;
			debug("GameState.state",GameState.state);
			if (GameState.state < GameState.BETS_CLOSED)
			{
				if (player.bet > 0)
				{
					view.enableClear();
					view.enableUndo();
					view.enableConfirm();
				}
				else
				{
					view.disbleClear();
					view.disbleUndo();
					checkForRepeatAndDouble();
				}
			}
		}

		private function onStageResize(event:Event):void
		{
			view.align();
		}

		private function debug(... args):void
		{
			GameUtils.log(this, args);
		}
	}
}
