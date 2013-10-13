package com.newco.grand.core.common.view.mediators
{

	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.TaskbarActionEvent;
	import com.newco.grand.core.common.controller.signals.TooltipEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.GameState;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.StyleModel;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.LanguageService;
	import com.newco.grand.core.common.view.SMButton;
	import com.newco.grand.core.common.view.interfaces.ITaskbarView;
	import com.newco.grand.core.utils.FormatUtils;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.external.ExternalInterface;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.signals.ErrorSignal;
	
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
		
		[Inject]
		public var langService:LanguageService;
		public var GAMELOBBY:String="GAMELOBBY";
		
		public var GAMEHELP:String="GAMEHELP";
		
		private var lobbyMC:MovieClip=new MovieClip();
		private var helpMC:MovieClip;
		private var loader:Loader = new Loader(); 
		
		private var preloader : MainPreloaderAsset;
		

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
		private function updateLanguage(signal:BaseSignal):void{
			view.updateLanguage();
		}

		private function setupModel(signal:BaseSignal):void
		{
			signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);
			view.init();
			contextView.view.addChild(lobbyMC);
			view.loadLanguages(urls.languages,urls.langICON);
			createMenuBar();
			addViewListeners();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
		
		}
		private function doLangChange(btn:SMButton):void{
			flashVars.lang=btn.params.lang;
			langService.load();
		}
		private function addViewListeners():void
		{
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
			view.signalBus.add(TaskbarActionEvent.LOAD_LANGUAGE, buttonAction);
		
		}

		private function createMenuBar():void
		{

			var menuXML:XML=new XML(StyleModel['MENUBAR_XML']);
			for each (var node:XML in menuXML.children())
			{
				var label:String=LanguageModel[String(node.@label).toLocaleUpperCase()] || node.@label;
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
		private function loadProgress(event:ProgressEvent):void {
			var percentLoaded:Number = event.bytesLoaded/event.bytesTotal;
			percentLoaded = Math.round(percentLoaded * 100);
			
			
			preloader.label.text=String(percentLoaded) +" %";
			preloader.gotoAndStop(percentLoaded);
			//trace("Loading: "+percentLoaded+"%");
		}   
		private function launchLobby(signal:BaseSignal):void {
 
			var lobbyUrl:String=urls.lobbySWF;
			if (FlashVars.PLATFORM==FlashVars.AIR_PLATFORM)
				lobbyUrl="LobbyMobile.swf";
			if (lobbyMC.numChildren<=0) {
				var request:URLRequest = new URLRequest(lobbyUrl+"?gametype=sublobby&user_id="+flashVars.user_id);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (evt:Event):void{
					lobbyMC.removeChild(preloader);
					var closeBtn:SMButton=new SMButton(new CloseButtonAsset());
					closeBtn.skin.x=1150;
					closeBtn.skin.y=5;
					if (FlashVars.PLATFORM==FlashVars.AIR_PLATFORM)
						closeBtn.skin.x=600;
					
					lobbyMC.addChild(closeBtn.skin);
					closeBtn.skin.addEventListener(MouseEvent.CLICK,function (evt:MouseEvent):void{
						lobbyMC.visible=false;
					})
				});   
				loader.load(request);
				lobbyMC.addChild(loader);
				
				preloader =new MainPreloaderAsset();
				preloader.x=(contextView.view.stage.stageWidth-preloader.width) /2;
				preloader.y=(contextView.view.stage.stageHeight-preloader.height) /2;
				preloader.stop();
				lobbyMC.addChild(preloader);

			} else
			{
				lobbyMC.visible=true;
			}
		
			
		}
		
		private function loadHelp():void{
			
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
				case TaskbarActionEvent.LOAD_LANGUAGE:
					flashVars.lang=signal.params.lang;
					signalBus.dispatch(LanguageAndStylesEvent.LANGUAGE_LOAD);
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
					view.showTooltip(target, game.fullscreen ? LanguageModel.RESTORE : LanguageModel.FULLSCREEN);
					break;
				case TaskbarActionEvent.HELP_CLICKED:
					view.showTooltip(target, LanguageModel.HELP);
					break;
				case TaskbarActionEvent.HISTORY_CLICKED:
					view.showTooltip(target, LanguageModel.HISTORY);
					break;
				case TaskbarActionEvent.SOUND_CLICKED:
					view.showTooltip(target, game.sound ? LanguageModel.SOUNDON:LanguageModel.SOUNDOFF);
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
/*			if (FlashVars.GAMECLIENT=="baccarat")
			 view.slideDownButtons();*/
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
			/*if (FlashVars.GAMECLIENT=="baccarat")
			view.slideUpButtons();*/
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
