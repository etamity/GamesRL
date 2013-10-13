package com.newco.grand.lobby.classic.controller.commands
{
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	
	import flash.net.URLRequest;
	
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.loaders.XMLLoader;
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;

	public class AvatarsDataCommand extends BaseCommand
	{
		[Inject]
		public var service:XMLService;
		[Inject]
		public var flashVars:FlashVars;
		[Inject]
		public var signalBus:SignalBus;
		[Inject]
		public var urlsModel:URLSModel;
		[Inject]
		public var lobbyModel:LobbyModel;
		public function AvatarsDataCommand()
		{

		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
		private function setConfig(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			lobbyModel.avatarData=xml;
			signalBus.dispatch(LobbyEvents.AVATAR_LOADED);
			signalBus.dispatch(LobbyEvents.LOBBYDATA_LOAD);
			signalBus.dispatch(BalanceEvent.LOAD);
		}
		private function showError(signal:ErrorSignal):void {
			debug("error " + signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message + "::" +urlsModel.lobbyAvatar+"avatars.xml"});
		}
		override public function execute():void {	
			service.loadURL(urlsModel.lobbyAvatar+"avatars.xml",setConfig,showError);
		}
	}
}