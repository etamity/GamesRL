package com.newco.grand.core.common.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ChatEvent;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.model.Chat;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.Language;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.interfaces.IChatView;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;

	
	public class ChatMediator extends Mediator{
		
		[Inject]
		public var view:IChatView;
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var chat:Chat;
		
		[Inject]
		public var flashVar:FlashVars;
		
		[Inject]
		public var contextView:ContextView;
		[Inject]
		public var signalBus:SignalBus;
		
		override public function initialize():void {

			signalBus.signal(ModelReadyEvent.READY).add(setupModel);
			signalBus.signal(SocketDataEvent.HANDLE_DEALER).add(setDealer);
			signalBus.signal(ChatEvent.SHOW_WELCOME_MESSAGE).add(setWelcomeMessage);
			signalBus.signal(ChatEvent.SHOW_MESSAGE).add(setMessage);
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);
			view.sendSignal.add(sendMessage);
		}
		
		private function sendMessage():void {
			chat.message = view.message;
			signalBus.signal(ChatEvent.SEND_MESSAGE);
			view.clear();
		}
		
		private function setDealer(signal:BaseSignal):void {
			view.dealer = Language.DEALER + ": " + game.dealer;
		}
		
		private function setWelcomeMessage(signal:BaseSignal):void {
			//view.setWelcomeMessage(chat.message);
			var welcome:String= "Welcome to Smart Gaming - " + game.table;
			view.setWelcomeMessage(welcome);
		}
		
		private function setMessage(signal:BaseSignal):void {
			var xml:XML=new XML(chat.message);
			var content:String=chat.message; // xml.text;
			
			view.setMessage(chat.sender, content);
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}