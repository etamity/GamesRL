package com.newco.grand.lobby.configs
{
	import com.newco.grand.core.common.controller.commands.BalanceCommand;
	import com.newco.grand.core.common.controller.commands.HelpSWFCommand;
	import com.newco.grand.core.common.controller.commands.HistorySWFCommand;
	import com.newco.grand.core.common.controller.commands.StartupCommand;
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.TaskbarActionEvent;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.SignalConstants;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.impl.BalanceService;
	import com.newco.grand.core.common.service.impl.ConfigService;
	import com.newco.grand.core.common.service.impl.HelpSWFService;
	import com.newco.grand.core.common.service.impl.HistorySWFService;
	import com.newco.grand.core.common.service.impl.URLSService;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.lobby.classic.controller.commands.LobbyDataCommand;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	import com.newco.grand.lobby.classic.view.HistoryView;
	import com.newco.grand.lobby.classic.view.LobbyView;
	import com.newco.grand.lobby.classic.view.TablesView;
	import com.newco.grand.lobby.classic.view.mediators.HistoryViewMediator;
	import com.newco.grand.lobby.classic.view.mediators.LobbyViewMediator;
	import com.newco.grand.lobby.classic.view.mediators.TablesViewMediator;
	
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

		protected var signalBus:SignalBus=new SignalBus();
		protected var service:IAssetLoader;
		protected var gameData:LobbyModel=new LobbyModel();

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
			injector.map(IGameData).toValue(gameData)
			injector.map(SignalBus).toValue(signalBus);
			injector.map(ConfigService).asSingleton();
			injector.map(XMLService).asSingleton();
			injector.map(URLSService).asSingleton();
			injector.map(URLSModel).asSingleton();
			injector.map(BalanceService).asSingleton();
			injector.map(HelpSWFService).asSingleton();
			injector.map(HistorySWFService).asSingleton();
		}
		
		public function mapMediators():void
		{
			mediatorMap.map(LobbyView).toMediator(LobbyViewMediator);
			mediatorMap.map(TablesView).toMediator(TablesViewMediator);
			mediatorMap.map(HistoryView).toMediator(HistoryViewMediator);
		}
		
		public function mapCommands():void
		{
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP), StartupCommand, true);
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP_COMPLETE), LobbyDataCommand, true);
			//commandMap.mapSignal(signalBus.signal(LobbyEvents.LOADHISTORY), HistoryCommand, true);
			commandMap.mapSignal(signalBus.signal(BalanceEvent.LOAD), BalanceCommand);
			commandMap.mapSignal(signalBus.signal(TaskbarActionEvent.HELP_CLICKED), HelpSWFCommand);
			commandMap.mapSignal(signalBus.signal(TaskbarActionEvent.HISTORY_CLICKED), HistorySWFCommand);

		}
		public function configure():void
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
			mediatorMap.mediate(contextView.view);
			contextView.view.addChild(new LobbyView());
			contextView.view.addChild(new TablesView());
			contextView.view.addChild(new HistoryView());
			signalBus.dispatch(SignalConstants.STARTUP);
		}
	}
}