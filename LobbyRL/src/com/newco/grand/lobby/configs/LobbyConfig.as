package com.newco.grand.lobby.configs
{
	import com.newco.grand.baccarat.classic.model.GameDataModel;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.SignalConstants;
	import com.newco.grand.lobby.classic.controller.commands.StartupCommand;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	
	import org.assetloader.AssetLoader;
	import org.assetloader.base.Param;
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.core.IParam;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.LogLevel;
	
	public class LobbyConfig implements IConfig
	{	
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:ISignalCommandMap;
		
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var contextView:ContextView;
		
		[Inject]
		public var flashVars:FlashVars;

		protected var signalBus:SignalBus=new SignalBus();
		protected var service:IAssetLoader;
		protected var gameData:LobbyModel=new LobbyModel();
		public function LobbyConfig()
		{			
			context.logLevel=LogLevel.DEBUG;
			
			createInstance();
			mapSingletons();
			mapMediators();
			mapCommands();
			//setupViews();
			context.afterInitializing(init);
		}
		public function init():void
		{
			
		}
		public function createInstance():void
		{
			//gameData.game=Constants.BACCARAT;
			//gameData.gameType=Constants.TYPE_CLASSIC;
			
			service=injector.getOrCreateNewInstance(AssetLoader);
			var param:IParam=new Param(Param.PREVENT_CACHE, true);
			service.addParam(param);
		}
		
		public function mapSingletons():void
		{
			injector.map(FlashVars).toValue(new FlashVars(contextView));
			injector.map(IAssetLoader).toValue(service);
			injector.map(Player).asSingleton();
			injector.map(LobbyModel).toValue(gameData);
		}
		
		public function mapMediators():void
		{
			
		}
		
		public function mapCommands():void
		{
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP), StartupCommand, true);
		}
		public function configure():void
		{
		}
	}
}