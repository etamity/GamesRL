package com.newco.grand.lobby.mobile.view.mediators
{
	import com.newco.grand.core.common.controller.signals.BaseSignal;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	import com.newco.grand.lobby.classic.model.TableModel;
	import com.newco.grand.lobby.mobile.view.LobbyView;
	
	import flash.display.Loader;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class LobbyViewMediator extends Mediator
	{
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var lobbyModel:LobbyModel;
		
		[Inject]
		public var view:LobbyView;
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var contextView:ContextView;
		public function LobbyViewMediator()
		{
			super();
		}
		
		override public function initialize():void{
			signalBus.add(LobbyEvents.SHOW_TABLE,showTables);
			view.opengameSginal.add(openGame);
		}
		
		private function showTables(signal:BaseSignal):void{
			var game:String=signal.params.game;
			
			var tables:Array= lobbyModel.getTables(game);
			view.loadTables(tables);
		}
		private function openGame(table:TableModel):void{

			var gameSWF:String;
			if (table.game ==Constants.BACCARAT.toLowerCase())
				gameSWF="BaccaratMobile.swf";
			if (table.game ==Constants.ROULETTE.toLowerCase())
				gameSWF="RouletteMobile.swf";	
			var url:String=gameSWF+"?game="+table.game+"&table_id="+table.tableid+"&gameType="+table.gameType+"&lang="+flashvars.lang+"&client="+flashvars.client;
			trace("url:",url);
			var urlRequest:URLRequest = new URLRequest(url);
			contextView.view.removeChildren();
			var loader:Loader=new Loader();
			loader.load(urlRequest);
			contextView.view.addChild(loader);
		}
	}
}