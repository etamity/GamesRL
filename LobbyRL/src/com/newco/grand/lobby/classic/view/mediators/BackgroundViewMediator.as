package com.newco.grand.lobby.classic.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.view.BackgroundView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class BackgroundViewMediator extends Mediator
	{
		[Inject]
		public var urlsModel:URLSModel;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var view:BackgroundView;
		
		
		[Inject]
		public var flashvars:FlashVars;
		public function BackgroundViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
			signalBus.add(LobbyEvents.LOBBYDATA_LOADED,doLoadBackground);	
		}
		
		private function doLoadBackground(signal:BaseSignal):void{
			view.loadBackground(urlsModel.lobbyBG);
		}
	}
}