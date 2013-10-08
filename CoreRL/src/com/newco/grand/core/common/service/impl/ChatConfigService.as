package com.newco.grand.core.common.service.impl
{
	import com.newco.grand.core.common.controller.signals.ChatEvent;
	import com.newco.grand.core.common.controller.signals.MessageEvent;
	import com.newco.grand.core.common.model.Chat;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.api.IService;
	import com.newco.grand.core.utils.GameUtils;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import org.assetloader.signals.ErrorSignal;
	import org.assetloader.signals.LoaderSignal;
	
	public class ChatConfigService implements IService
	{
		
		[Inject]
		public var service:XMLService;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var game:IGameData;
		
		[Inject]
		public var player:Player;
		
		[Inject]
		public var chat:Chat;
		
		[Inject]
		public var flashvars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		public function ChatConfigService()
		{
		}
		
		public function load(onComplete:Function=null):void
		{
			loadState();
		}
		private function loadState():void {
			debug(urls.chatConfig + "?room_id=" + flashvars.room);
			/*service.addLoader(new XMLLoader(new URLRequest(urls.chatConfig + "?room_id=" + flashvars.room), Constants.SERVER_CHAT_CONFIG));
			service.getLoader(Constants.SERVER_CHAT_CONFIG).onError.add(showError);
			service.getLoader(Constants.SERVER_CHAT_CONFIG).onComplete.add(setConfig);			
			service.start();*/
			
			service.loadURL(urls.chatConfig,setConfig,showError);
		}
		
		private function setConfig(signal:LoaderSignal, xml:XML):void {
			debug(xml);
			player.id = xml.userid;
			player.name = xml.username;
			player.type = xml.usertype;
			chat.server = xml.server;
			chat.port = xml.port;
			debug("chat.port",chat.port);
			chat.room = xml.room;
			flashvars.room=chat.room;
			/*chat.serverSignupPath = xml.server_signup_path;
			chat.serverSignupString = xml.server_signup_string;	*/		
			
			//service.remove(Constants.SERVER_CHAT_CONFIG);
			//authenticateChat();
			signalBus.dispatch(ChatEvent.CONNECT);
		}
		
		private function authenticateChat():void {
			debug(chat.serverSignupPath + " encode: " + chat.serverSignupString);
			var request:URLRequest = new URLRequest(chat.serverSignupPath);
			var variables:URLVariables = new URLVariables();
			variables.encoded = chat.serverSignupString;
			request.data = variables;
			request.method = URLRequestMethod.POST;
			
			/*service.addLoader(new XMLLoader(request, Constants.SERVER_CHAT_SIGNUP));
			service.getLoader(Constants.SERVER_CHAT_SIGNUP).onError.add(showError);
			service.getLoader(Constants.SERVER_CHAT_SIGNUP).onComplete.add(connectToChatServer);
			service.start();*/
			//service.parameters=variables;
			service.loadURL(chat.serverSignupPath,connectToChatServer,showError);
			
			signalBus.dispatch(ChatEvent.CONNECT);
		}
		
		private function connectToChatServer(signal:LoaderSignal, xml:XML):void {
			debug(xml);			
			//service.remove(Constants.SERVER_CHAT_SIGNUP);			
			signalBus.dispatch(ChatEvent.CONNECT);
		}
		
		private function showError(signal:ErrorSignal):void {
			debug("Error:" +signal.message);
			signalBus.dispatch(MessageEvent.SHOWERROR,{target:this,error:signal.message});
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}