package com.newco.grand.core.common.view.mediators {
	
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.controller.signals.SocketDataEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.WinnersEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.view.uicomps.WinnersUIView;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.events.Event;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class WinnersViewMediator extends Mediator {
		
		[Inject]
		public var view:WinnersUIView;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var contextView:ContextView;	
		public static var count : int=0;
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel,true);
			signalBus.add(WinnersEvent.LOADED, showPlayers);
			signalBus.add(UIEvent.RESIZE, resize);
			signalBus.add(SocketDataEvent.HANDLE_BET, handleBet);
			count++;
			debug("count",count);
			//signalBus.add(LanguageAndStylesEvent.LANGUAGE_LOADED, updateLanguage);		
		}
		private function handleBet(signal:BaseSignal):void {
			debug("handleBet");
			var userid:String=signal.params.node.@userid;
			var amount:String=String(Number(signal.params.node.@banker) 
				+ Number(signal.params.node.@player) 
				+ Number(signal.params.node.@pair_banker)
				+ Number(signal.params.node.@pair_player)
				+ Number(signal.params.node.@tie));
			view.updateBetAmounts(userid,amount);
		}
		private function updateLanguage(signal:BaseSignal):void {
			view.updateLanguage();
			
		}
		
		private function setupModel(signal:BaseSignal):void {
			view.init();
			eventMap.mapListener(contextView.view.stage, Event.RESIZE, onStageResize);

		}
		
		public function resize(signal:BaseSignal):void{
			var ww:int= signal.params.width;
			var hh:int= signal.params.height;
			view.resize(ww,hh);
		}
		
		private function showPlayers(signal:BaseSignal):void {
			view.players =signal.params.node;
		}
		
		private function onStageResize(event:Event):void {
			view.align();
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}