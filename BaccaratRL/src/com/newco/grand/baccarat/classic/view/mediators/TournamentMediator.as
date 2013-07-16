package com.newco.grand.baccarat.classic.view.mediators
{
	import com.newco.grand.baccarat.classic.view.TournamentView;
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.controller.signals.ModelReadyEvent;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class TournamentMediator extends Mediator
	{	[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var view:TournamentView;
		[Inject]
		public var urls:URLSModel;
		
		public function TournamentMediator()
		{
			super();
		}
		override public function initialize():void {
			signalBus.add(ModelReadyEvent.READY, setupModel);
			
		}
		private function setupModel(signal:BaseSignal):void {
			view.loadXML(urls.tournament);	
		}
		

	}
}