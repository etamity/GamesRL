package com.ai.core.view.mediators
{

	import com.ai.core.controller.signals.BalanceEvent;
	import com.ai.core.controller.signals.BaseSignal;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.ModelReadyEvent;
	import com.ai.core.controller.signals.SocketDataEvent;
	import com.ai.core.controller.signals.StateTableConfigEvent;
	import com.ai.core.controller.signals.TaskbarActionEvent;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.GameState;
	import com.ai.core.model.IGameData;
	import com.ai.core.model.Language;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.Style;
	import com.ai.core.utils.FormatUtils;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.TaskbarView;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class TaskbarMediator extends Mediator
	{

		[Inject]
		public var view:TaskbarView;

		[Inject]
		public var player:Player;

		[Inject]
		public var flashVars:FlashVars;

		[Inject]
		public var game:IGameData;

		[Inject]
		public var signalBus:SignalBus;
		
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
			view.balanceLabel=Language.BALANCE;
			view.betLabel=Language.BET;
			view.gameLabel=Language.GAMEID;
			view.myaccountLabel=Language.MYACCOUNT;
			view.myaccountLabel="";
			/*view.repeatLabel = Language.REBET;
			view.doubleLabel = Language.DOUBLEBET;
			view.undoLabel = Language.UNDO;
			view.clearLabel = Language.CLEARALL;*/

			view.repeatButton.label=Language.REBET;
			view.doubleButton.label=Language.DOUBLEBET;
			view.undoButton.label=Language.UNDO;
			view.clearButton.label=Language.CLEARALL
			view.confirmButton.label=Language.CONFIRM;
			view.favouritesButton.label=Language.FAVOURITES
				
				
			view.lobbyLabel=Language.LOBBY;
			createMenuBar();
			addViewListeners();
			view.soundButtonON_OFF=SoundMixer.soundTransform.volume;
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
		}

		private function addViewListeners():void
		{

			view.chipClickedSignal.add(onChipClicked);
			view.buttonClickedSignal.add(buttonAction);
			view.menuitemClickedSignal.add(menuItemClicked);
			view.showDefaultSignal.add(showTooltip);
			view.undoSignal.add(betButtonAction);
			view.clearClickedSignal.add(betButtonAction);
			view.repeatClickedSignal.add(betButtonAction);
			view.doubleClickedSignal.add(betButtonAction);
			view.confirmClickedSignal.add(betButtonAction);
			view.favouritesClickedSignal.add(betButtonAction);
			
			
			/*view.addEventListener(TaskbarActionEvent.BUTTON_CLICKED, buttonAction);
			view.addEventListener(TaskbarActionEvent.MENUITEM_CLICKED, menuItemClicked);
			view.addEventListener(TooltipEvent.SHOW_DEFAULT, showTooltip);
			view.addEventListener(BetEvent.UNDO, betButtonAction);
			view.addEventListener(BetEvent.CLEAR, betButtonAction);
			view.addEventListener(BetEvent.REPEAT, betButtonAction);
			view.addEventListener(BetEvent.DOUBLE, betButtonAction);
			view.addEventListener(BetEvent.CONFRIM, betButtonAction);
			view.addEventListener(BetEvent.FAVOURITES, betButtonAction);*/
			
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
					view.menuItem.createMenuItem(label, url);
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

		private function onChipClicked():void
		{
			game.chipSelected=view.chipSelected;
			//eventDispatcher.dispatchEvent(event);
			signalBus.dispatch(TaskbarActionEvent.CHIP_CLICKED);
		}

		private function buttonAction(target:MovieClip):void
		{
			switch (target)
			{
				case view.fullscreen:
					signalBus.dispatch(TaskbarActionEvent.FULLSCREEN_CLICKED);
					break;
				case view.help:
					//eventDispatcher.dispatchEvent(new TaskbarActionEvent(TaskbarActionEvent.HELP_CLICKED));
					signalBus.dispatch(TaskbarActionEvent.HELP_CLICKED);
					break;
				case view.history:
					//eventDispatcher.dispatchEvent(new TaskbarActionEvent(TaskbarActionEvent.HISTORY_CLICKED));
					signalBus.dispatch(TaskbarActionEvent.HISTORY_CLICKED);
					break;
				case view.sound:
					//eventDispatcher.dispatchEvent(new TaskbarActionEvent(TaskbarActionEvent.SOUND_CLICKED));
					signalBus.dispatch(TaskbarActionEvent.SOUND_CLICKED);
					view.soundButtonON_OFF=SoundMixer.soundTransform.volume;
					break;
				case view.lobby:
					//eventDispatcher.dispatchEvent(new TaskbarActionEvent(TaskbarActionEvent.LOBBY_CLICKED));
					signalBus.dispatch(TaskbarActionEvent.LOBBY_CLICKED);
					break;
			}
		}

		private function showTooltip(target:MovieClip):void
		{
			switch (target)
			{
				case view.fullscreen:
					view.showTooltip(target, game.fullscreen ? Language.RESTORE : Language.FULLSCREEN);
					break;
				case view.help:
					view.showTooltip(target, Language.HELP);
					break;
				case view.history:
					view.showTooltip(target, Language.HISTORY);
					break;
				case view.sound:
					view.showTooltip(target, game.sound ? Language.SOUNDON:Language.SOUNDOFF);
					break;
			}
		}

		private function betButtonAction(type:String):void
		{
			//eventDispatcher.dispatchEvent(event);
			signalBus.dispatch(type);
			switch (type) {
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
			view.disbleUndo();
			view.disbleClear();
			view.disbleRepeat();
			view.disbleDouble();
			view.disbleChips();
			view.disbleFavourites();
			view.disbleConfirm();
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
