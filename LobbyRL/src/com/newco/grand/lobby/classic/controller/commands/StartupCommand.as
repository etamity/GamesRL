package com.newco.grand.lobby.classic.controller.commands
{
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;

	public class StartupCommand extends BaseCommand
	{
		[Inject]
		public var service:IAssetLoader;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var player:Player;
		
		[Inject]
		public var lobbyModel:LobbyModel;

		private const URLS_XML:String= "LOBBY_XML";
		private var _xmlurl:String="xml/lobby.xml";
		public function StartupCommand()
		{

		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
		private function setConfig(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			player.balance=xml.balance;
			lobbyModel.data=xml;
			signalBus.dispatch(LobbyEvents.DATALOADED);
		}
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message + "::" +_xmlurl});
		}
		override public function execute():void {	
			if(flashVars.localhost) {
				service.addLoader(new XMLLoader(new URLRequest(_xmlurl), URLS_XML));
				service.getLoader(URLS_XML).onError.add(showError);
				service.getLoader(URLS_XML).onComplete.add(setConfig);			
				service.start();
			}else
			{
				
			}
		}
	}
}