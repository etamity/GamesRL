package com.newco.grand.lobby.configs
{
	import com.newco.grand.core.common.controller.commands.BalanceCommand;
	import com.newco.grand.core.common.controller.commands.HelpSWFCommand;
	import com.newco.grand.core.common.controller.commands.HistorySWFCommand;
	import com.newco.grand.core.common.controller.commands.LanguageAndStylesCommand;
	import com.newco.grand.core.common.controller.commands.LanguageCommand;
	import com.newco.grand.core.common.controller.commands.LoginCommand;
	import com.newco.grand.core.common.controller.commands.StartupCommand;
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
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
	import com.newco.grand.core.common.service.impl.LanguageService;
	import com.newco.grand.core.common.service.impl.LoginService;
	import com.newco.grand.core.common.service.impl.StyleService;
	import com.newco.grand.core.common.service.impl.URLSService;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.core.common.view.LoginView;
	import com.newco.grand.core.common.view.StageView;
	import com.newco.grand.core.common.view.interfaces.ILoginView;
	import com.newco.grand.core.common.view.interfaces.IStageView;
	import com.newco.grand.core.common.view.mediators.LoginMediator;
	import com.newco.grand.core.common.view.mediators.StageMediator;
	import com.newco.grand.lobby.classic.controller.commands.AvatarsDataCommand;
	import com.newco.grand.lobby.classic.controller.commands.LobbyDataCommand;
	import com.newco.grand.lobby.classic.controller.commands.StartupCompleteCommand;
	import com.newco.grand.lobby.classic.controller.commands.StartupDataCommand;
	import com.newco.grand.lobby.classic.controller.signals.LobbyEvents;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	import com.newco.grand.lobby.classic.view.BackgroundView;
	import com.newco.grand.lobby.classic.view.HistoryView;
	import com.newco.grand.lobby.classic.view.LobbyView;
	import com.newco.grand.lobby.classic.view.TablesView;
	import com.newco.grand.lobby.classic.view.mediators.BackgroundViewMediator;
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
			injector.map(LanguageService).asSingleton();
			injector.map(StyleService).asSingleton();
			injector.map(LoginService).asSingleton();
		}
		
		public function mapMediators():void
		{
			mediatorMap.map(IStageView).toMediator(StageMediator);
			mediatorMap.map(LobbyView).toMediator(LobbyViewMediator);
			mediatorMap.map(TablesView).toMediator(TablesViewMediator);
			mediatorMap.map(HistoryView).toMediator(HistoryViewMediator);
			mediatorMap.map(BackgroundView).toMediator(BackgroundViewMediator);
			mediatorMap.map(ILoginView).toMediator(LoginMediator);
		}
		
		public function mapCommands():void
		{
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP), StartupCommand, true);
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP_COMPLETE), StartupCompleteCommand, true);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.LOAD), StartupDataCommand, true);
			commandMap.mapSignal(signalBus.signal(LobbyEvents.LOBBYDATA_LOAD), LobbyDataCommand, true);
			commandMap.mapSignal(signalBus.signal(LobbyEvents.AVATARS_LOAD), AvatarsDataCommand, true);
			//commandMap.mapSignal(signalBus.signal(LobbyEvents.LOADHISTORY), HistoryCommand, true);
			commandMap.mapSignal(signalBus.signal(BalanceEvent.LOAD), BalanceCommand);
			commandMap.mapSignal(signalBus.signal(TaskbarActionEvent.HELP_CLICKED), HelpSWFCommand);
			commandMap.mapSignal(signalBus.signal(TaskbarActionEvent.HISTORY_CLICKED), HistorySWFCommand);
			commandMap.mapSignal(signalBus.signal(LanguageAndStylesEvent.LOAD), LanguageAndStylesCommand, true);
			commandMap.mapSignal(signalBus.signal(LanguageAndStylesEvent.LANGUAGE_LOAD), LanguageCommand);
			commandMap.mapSignal(signalBus.signal(LoginEvent.LOGIN), LoginCommand);
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
			contextView.view.addChild(new StageView());
			contextView.view.addChild(new BackgroundView());
			contextView.view.addChild(new LoginView());
			contextView.view.addChild(new LobbyView());
			
			contextView.view.addChild(new TablesView());
			
			//contextView.view.addChild(new HistoryView());
			signalBus.dispatch(SignalConstants.STARTUP);
		}
	}
}