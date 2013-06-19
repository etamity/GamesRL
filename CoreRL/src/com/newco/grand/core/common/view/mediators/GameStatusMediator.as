package com.newco.grand.core.common.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.Language;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.interfaces.IGameStatusView;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.core.utils.StringUtils;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;


	public class GameStatusMediator extends Mediator{
		
		[Inject]
		public var view :IGameStatusView;
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;
		
		private const TIMER_COLOR_DEFAULT:uint = 0x00FF00;
		private const TIMER_COLOR_CLOSING:uint = 0xFFFF00;
		private const TIMER_COLOR_CLOSED:uint = 0xFF0000;
		
		private const MESSAGE_COLOR_ERROR:uint = 0x990000;
		private const MESSAGE_COLOR_WARNING:uint = 0xFF9900;
		private const MESSAGE_COLOR_SUCCESS:uint = 0x009900;
		
		private var _timer:Timer;
		
		override public function initialize():void {
			
			signalBus.add(ModelReadyEvent.READY,setupModel);
			signalBus.add(SocketDataEvent.HANDLE_TIMER,startTimer);
			signalBus.add(SocketDataEvent.HANDLE_RESULT,setMessage);
			signalBus.add(SocketDataEvent.HANDLE_CANCEL,setMessage);
			signalBus.add(BetEvent.BETS_ACCEPTED,setBetMessage);
			signalBus.add(BetEvent.BETS_REJECTED,setBetMessage);
			signalBus.add(BetEvent.CLOSE_BETS,setBetMessage);
			signalBus.add(BetEvent.NOT_ALL_BETS_ACCEPTED,setBetMessage);
			signalBus.add(MessageEvent.SHOW_NOT_ENOUGH_MONEY,setLimitsMessage);
			signalBus.add(MessageEvent.SHOW_MIN_SPOT,setLimitsMessage);
			signalBus.add(MessageEvent.SHOW_MAX_SPOT,setLimitsMessage);
			signalBus.add(MessageEvent.SHOW_WINNINGS,showWinnings);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			view.message = Language.PLEASEWAIT;
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
		}

		private function startTimer(signal:BaseSignal):void {
			view.message = Language.PLACEBETS;
			view.timerColor = TIMER_COLOR_DEFAULT;
			view.timer = (game.countdown < 10) ? "0" + game.countdown : "" + game.countdown;
			_timer = new Timer(1000, game.countdown);
			_timer.start();
			_timer.addEventListener(TimerEvent.TIMER, countdown);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, reset);
			view.setLightOn("green");
		}
		
		private function countdown(event:TimerEvent):void {
			var countdown:Number = game.countdown - _timer.currentCount;
			view.timer = (countdown < 10) ? "0" + countdown : "" + countdown;			
			if (game.countdown - _timer.currentCount == 5) {
				view.setLightOn("amber");
				view.timerColor = TIMER_COLOR_CLOSING;
				view.message = Language.BETSCLOSING;
			}
		}
		
		private function reset(evt:TimerEvent):void {
			view.message = Language.NOMOREBETS;			view.timerColor = TIMER_COLOR_CLOSED;
			view.timer = "00";
			_timer.stop();
			view.setLightSOff();
			//eventDispatcher.dispatchEvent(new BetEvent(BetEvent.CLOSE_BETS));
			signalBus.dispatch(BetEvent.CLOSE_BETS);
		}
		
		private function stopTimer():void {
			view.timer = "00";
			view.timerColor = TIMER_COLOR_CLOSED;
			if (_timer != null && _timer.running) {
				_timer.stop();
				
			}
		}
		
		private function isRunning():Boolean {
			if (_timer != null) {
				return _timer.running;
			}
			else {
				return false;
			}
		}
		
		private function setMessage(signal:BaseSignal):void {
			switch(signal.type) {
				case SocketDataEvent.HANDLE_RESULT:
					view.message = String(game.statusMessage).toUpperCase();
					break;
				
				case SocketDataEvent.HANDLE_CANCEL:
					view.message = Language.GAMECANCELLED;
					view.highlightMessageBG(MESSAGE_COLOR_ERROR);
					stopTimer();
					break;
			}
		}
		
		private function setBetMessage(signal:BaseSignal):void {
			switch(signal.type) {
				case BetEvent.BETS_ACCEPTED:
					
					view.message = Language.BETSACCEPTED;
					
					break;
				
				case BetEvent.NOT_ALL_BETS_ACCEPTED:
					view.message = Language.NOTALLBETSACCEPTED;
					view.highlightMessageBG(MESSAGE_COLOR_WARNING);
					break;
				
				case BetEvent.BETS_REJECTED:
					view.message = Language.BETSREJECTED;
					view.highlightMessageBG(MESSAGE_COLOR_ERROR);
					break;
				case BetEvent.CLOSE_BETS:
					view.message = Language.NOMOREBETS;
					view.highlightMessageBG(TIMER_COLOR_CLOSED);
					view.setLightOn("red");
					break;
			}
		}
		
		private function setLimitsMessage(signal:BaseSignal):void {
			switch(signal.type) {
				case MessageEvent.SHOW_NOT_ENOUGH_MONEY:
					view.message = Language.NOTENOUGHMONEY;
					break;
				case MessageEvent.SHOW_MAX_TABLE:
					view.message = StringUtils.replace(Language.MAXTABLEBETIS, "#bet#", player.currencyCode + game.max);
					break;
				case MessageEvent.SHOW_MAX_SPOT:
					view.message = StringUtils.replace(Language.MAXBETIS, "#bet#", player.currencyCode + signal.params.target.max);
				case MessageEvent.SHOW_MIN_SPOT:
					view.message = StringUtils.replace(Language.MINBETIS, "#bet#", player.currencyCode + signal.params.target.min);
					break;
			}
			view.highlightMessageBG(MESSAGE_COLOR_ERROR);
		}
		
		private function showWinnings(signal:BaseSignal):void {
			var winnings:Number= player.winnings;
			setTimeout(function():void {
				var winningStr:String=StringUtils.replace(Language.YOUWON, "#winnings#", player.currencyCode + String(StringUtils.floatCorrection(winnings)));
				view.message =winningStr; 
				view.highlightMessageBG(MESSAGE_COLOR_SUCCESS);
				signalBus.dispatch(BalanceEvent.LOAD);
			}, 2000);


		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}