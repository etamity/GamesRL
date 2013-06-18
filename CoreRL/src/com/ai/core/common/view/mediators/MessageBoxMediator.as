package com.ai.core.common.view.mediators
{
	import com.ai.core.common.controller.signals.BaseSignal;
	import com.ai.core.common.controller.signals.BetEvent;
	import com.ai.core.common.controller.signals.MessageEvent;
	import com.ai.core.common.controller.signals.ModelReadyEvent;
	import com.ai.core.common.controller.signals.SocketDataEvent;
	import com.ai.core.common.model.IGameData;
	import com.ai.core.common.model.Language;
	import com.ai.core.common.model.Player;
	import com.ai.core.common.model.SignalBus;
	import com.ai.core.utils.GameUtils;
	import com.acom.ai.core.common.view.MessageBoxViewort com.ai.core.view.MessageBoxView;
	
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import robotlegs.bender.bundles.mvcs.Mediator;

	public class MessageBoxMediator extends Mediator
	{
		[Inject]
		public var view:MessageBoxView;
		
		[Inject]
		public var game:IGameData;
		
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var signalBus:SignalBus;
		
		private const TIMER_COLOR_DEFAULT:uint = 0x00FF00;
		private const TIMER_COLOR_CLOSING:uint = 0xFFFF00;
		private const TIMER_COLOR_CLOSED:uint = 0xFF0000;
		
		private const MESSAGE_COLOR_ERROR:uint = 0x990000;
		private const MESSAGE_COLOR_WARNING:uint = 0xFF9900;
		private const MESSAGE_COLOR_SUCCESS:uint = 0x009900;
		
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
			eventMap.mapListener(view.stage, Event.RESIZE, onStageResize);
		}
		
		private function startTimer(signal:BaseSignal):void{
			view.message = Language.PLACEBETS;
			view.removeMessageHighlightBG();
		}
		private function setMessage(signal:BaseSignal):void {
			switch(signal.type) {
				case SocketDataEvent.HANDLE_RESULT:
					view.message = String(game.resultXML).toUpperCase();
					break;
				
				case SocketDataEvent.HANDLE_CANCEL:
					view.message = Language.GAMECANCELLED;
					view.highlightMessageBG(MESSAGE_COLOR_ERROR);
					//stopTimer();
					break;
			}
			view.show();
		}
		
		private function setBetMessage(signal:BaseSignal):void {
			switch(signal.type) {
				case BetEvent.BETS_ACCEPTED:
					view.message = Language.BETSACCEPTED;
					view.highlightMessageBG(TIMER_COLOR_DEFAULT);
					break;
				
				case BetEvent.NOT_ALL_BETS_ACCEPTED:
					view.message = Language.NOTALLBETSACCEPTED;
					view.highlightMessageBG(MESSAGE_COLOR_WARNING);
					break;
				
				case BetEvent.BETS_REJECTED:
					view.message = Language.BETSREJECTED;
					view.highlightMessageBG(MESSAGE_COLOR_ERROR);
					break;
			}
			view.show();
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
					//view.message = StringUtils.replace(Language.MAXBETIS, "#bet#", player.currencyCode + event.obj.max);
					break;
			}
			view.highlightMessageBG(MESSAGE_COLOR_ERROR);
			view.show();
		}
		
		private function showWinnings(signal:BaseSignal):void {
			setTimeout(function():void {
				view.message = StringUtils.replace(Language.YOUWON, "#winnings#", player.currencyCode + player.winnings);
				view.highlightMessageBG(MESSAGE_COLOR_SUCCESS);
			}, 2000);
			view.show();
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}