package com.newco.grand.roulette.configs
{
	import com.newco.grand.core.common.controller.commands.BalanceCommand;
	import com.newco.grand.core.common.controller.commands.BetsCommand;
	import com.newco.grand.core.common.controller.commands.HelpSWFCommand;
	import com.newco.grand.core.common.controller.commands.HistorySWFCommand;
	import com.newco.grand.core.common.controller.commands.LanguageAndStylesCommand;
	import com.newco.grand.core.common.controller.commands.LanguageCommand;
	import com.newco.grand.core.common.controller.commands.LoginCommand;
	import com.newco.grand.core.common.controller.commands.SeatCommand;
	import com.newco.grand.core.common.controller.commands.SocketConnectionCommand;
	import com.newco.grand.core.common.controller.commands.StartupCommand;
	import com.newco.grand.core.common.controller.commands.StartupCompleteCommand;
	import com.newco.grand.core.common.controller.commands.StartupDataCommand;
	import com.newco.grand.core.common.controller.commands.VideoConnectionCommand;
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.LanguageAndStylesEvent;
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.controller.signals.SocketEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.TaskbarActionEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.model.Chat;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.SignalConstants;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.model.VideoModel;
	import com.newco.grand.core.common.service.ChatSocketService;
	import com.newco.grand.core.common.service.ISocketService;
	import com.newco.grand.core.common.service.impl.BalanceService;
	import com.newco.grand.core.common.service.impl.ChatConfigService;
	import com.newco.grand.core.common.service.impl.ConfigService;
	import com.newco.grand.core.common.service.impl.HelpSWFService;
	import com.newco.grand.core.common.service.impl.HistorySWFService;
	import com.newco.grand.core.common.service.impl.LanguageService;
	import com.newco.grand.core.common.service.impl.LoginService;
	import com.newco.grand.core.common.service.impl.PlayerService;
	import com.newco.grand.core.common.service.impl.SeatService;
	import com.newco.grand.core.common.service.impl.SendBetsService;
	import com.newco.grand.core.common.service.impl.StyleService;
	import com.newco.grand.core.common.service.impl.URLSService;
	import com.newco.grand.core.common.service.impl.WinnerListService;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.core.common.view.interfaces.IAccordion;
	import com.newco.grand.core.common.view.interfaces.IChatView;
	import com.newco.grand.core.common.view.interfaces.IErrorMessageView;
	import com.newco.grand.core.common.view.interfaces.IGameStatusView;
	import com.newco.grand.core.common.view.interfaces.ILoginView;
	import com.newco.grand.core.common.view.interfaces.IStageView;
	import com.newco.grand.core.common.view.interfaces.ITaskbarView;
	import com.newco.grand.core.common.view.interfaces.IVideoView;
	import com.newco.grand.core.common.view.mediators.ChatMediator;
	import com.newco.grand.core.common.view.mediators.ErrorMessageMediator;
	import com.newco.grand.core.common.view.mediators.GameStatusMediator;
	import com.newco.grand.core.common.view.mediators.LoginMediator;
	import com.newco.grand.core.common.view.mediators.PlayersMediator;
	import com.newco.grand.core.common.view.mediators.StageMediator;
	import com.newco.grand.core.common.view.mediators.TaskbarMediator;
	import com.newco.grand.core.common.view.mediators.VideoMediator;
	import com.newco.grand.core.common.view.mediators.WinnersViewMediator;
	import com.newco.grand.core.common.view.uicomps.PlayersUIView;
	import com.newco.grand.core.common.view.uicomps.WinnersUIView;
	import com.newco.grand.roulette.classic.controller.commands.SetupAssetCommand;
	import com.newco.grand.roulette.classic.controller.commands.StateTableConfigCommand;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	import com.newco.grand.roulette.classic.service.GameSocketService;
	import com.newco.grand.roulette.classic.service.TableConfigService;
	import com.newco.grand.roulette.classic.view.FavouritesBetsView;
	import com.newco.grand.roulette.classic.view.PlayersBetsView;
	import com.newco.grand.roulette.classic.view.StageInfoView;
	import com.newco.grand.roulette.classic.view.StatisticsView;
	import com.newco.grand.roulette.classic.view.interfaces.IBetSpotsView;
	import com.newco.grand.roulette.classic.view.interfaces.ILimitsView;
	import com.newco.grand.roulette.classic.view.interfaces.ILobbyView;
	import com.newco.grand.roulette.classic.view.interfaces.IResultsClassicView;
	import com.newco.grand.roulette.classic.view.mediators.BetSpotsMediator;
	import com.newco.grand.roulette.classic.view.mediators.FavouritesBetsMediator;
	import com.newco.grand.roulette.classic.view.mediators.LimitsMediator;
	import com.newco.grand.roulette.classic.view.mediators.LobbyMediator;
	import com.newco.grand.roulette.classic.view.mediators.PlayersBetsMediator;
	import com.newco.grand.roulette.classic.view.mediators.ResultsClassicMediator;
	import com.newco.grand.roulette.classic.view.mediators.RouletteAccordionMediator;
	import com.newco.grand.roulette.classic.view.mediators.StageInfoMediator;
	import com.newco.grand.roulette.classic.view.mediators.StatisticsMediator;
	import com.newco.grand.roulette.mobile.controller.commands.SetupLayoutCommand;
	import com.newco.grand.roulette.mobile.controller.commands.SetupViewCommand;
	
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
	
	public class RouletteMobileConfig implements IConfig
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
		
		protected var gameData:GameDataModel=new GameDataModel();
		
		protected var signalBus:SignalBus=new SignalBus();
		
		protected var service:IAssetLoader;
		
		public function RouletteMobileConfig()
		{
		}
		
		public function configure():void
		{      
			context.logLevel = LogLevel.DEBUG;
			
			createInstance();
			
			mapSingletons();
			mapMediators();
			mapCommands();
			//setupView();
			context.afterInitializing(init);
			
		}
		
		public function createInstance():void{
			gameData.game=Constants.ROULETTE;
			gameData.gameType=Constants.TYPE_CLASSIC;
			
			service=injector.getOrCreateNewInstance(AssetLoader);
			var param:IParam=new Param(Param.PREVENT_CACHE, true);
			service.addParam(param);
		}
		
		
		public function init():void{
			mediatorMap.mediate(contextView.view);
			signalBus.dispatch(SignalConstants.STARTUP);
			
		}
		/*private function setupView():void {
		contextView.view.addChild(new StageView());
		contextView.view.addChild(new LoginView());
		contextView.view.addChild(new AccordionUIView());
		contextView.view.addChild(new BetSpotsView());
		contextView.view.addChild(new LimitsView());
		contextView.view.addChild(new GameStatusView());
		contextView.view.addChild(new ChatView());
		contextView.view.addChild(new ResultsClassicView());
		contextView.view.addChild(new TaskbarView());
		//contextView.view.addChild(new MessageBoxView());
		contextView.view.addChild(new LobbyView());
		contextView.view.addChild(new VideoView());
		//contextView.addChild(new StageInfoView());
		
		}*/
		
		public function mapSingletons():void{
			injector.map(FlashVars).toValue(new FlashVars(contextView));
			injector.map(IAssetLoader).toValue(service);
			injector.map(ISocketService).toSingleton(GameSocketService);
			injector.map(ChatSocketService).toSingleton(ChatSocketService);
			injector.map(VideoModel).asSingleton();
			injector.map(URLSModel).asSingleton();
			injector.map(Player).asSingleton();
			injector.map(Chat).asSingleton();
			injector.map(IGameData).toValue(gameData)
			injector.map(GameDataModel).toValue(gameData);
			injector.map(SignalBus).toValue(signalBus);
			
			injector.map(XMLService).asSingleton();
			injector.map(ConfigService).asSingleton();
			injector.map(URLSService).asSingleton();
			injector.map(LoginService).asSingleton();
			injector.map(WinnerListService).asSingleton();
			injector.map(LanguageService).asSingleton();
			injector.map(StyleService).asSingleton();
			injector.map(BalanceService).asSingleton();
			injector.map(SendBetsService).asSingleton();
			injector.map(PlayerService).asSingleton();
			injector.map(ChatConfigService).asSingleton();
			injector.map(SeatService).asSingleton();
			injector.map(TableConfigService).asSingleton();
			injector.map(HelpSWFService).asSingleton();
			injector.map(HistorySWFService).asSingleton();
			
			
		}
		public function mapMediators():void{
			mediatorMap.map(IStageView).toMediator(StageMediator);
			mediatorMap.map(ILoginView).toMediator(LoginMediator);
			mediatorMap.map(IBetSpotsView).toMediator(BetSpotsMediator);
			mediatorMap.map(IVideoView).toMediator(VideoMediator);
			mediatorMap.map(ILimitsView).toMediator(LimitsMediator);
			mediatorMap.map(IResultsClassicView).toMediator(ResultsClassicMediator);
			mediatorMap.map(ITaskbarView).toMediator(TaskbarMediator);
			mediatorMap.map(StageInfoView).toMediator(StageInfoMediator);
			mediatorMap.map(IGameStatusView).toMediator(GameStatusMediator);
			mediatorMap.map(IChatView).toMediator(ChatMediator);
			mediatorMap.map(PlayersUIView).toMediator(PlayersMediator);
			mediatorMap.map(WinnersUIView).toMediator(WinnersViewMediator);
			mediatorMap.map(PlayersBetsView).toMediator(PlayersBetsMediator);
			mediatorMap.map(FavouritesBetsView).toMediator(FavouritesBetsMediator);
			mediatorMap.map(IAccordion).toMediator(RouletteAccordionMediator);
			mediatorMap.map(StatisticsView).toMediator(StatisticsMediator);
			mediatorMap.map(IErrorMessageView).toMediator(ErrorMessageMediator);
			//mediatorMap.map(MessageBoxView).toMediator(MessageBoxMediator);
			mediatorMap.map(ILobbyView).toMediator(LobbyMediator);
			
		}
		public function mapCommands():void{
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP), StartupCommand, true);
			
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP_COMPLETE), StartupCompleteCommand, true);
			
			commandMap.mapSignal(signalBus.signal(LoginEvent.LOGIN), LoginCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.SEAT), SeatCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.LOAD), StartupDataCommand);
			commandMap.mapSignal(signalBus.signal(LanguageAndStylesEvent.LOAD), LanguageAndStylesCommand, true);
			commandMap.mapSignal(signalBus.signal(LanguageAndStylesEvent.LANGUAGE_LOAD), LanguageCommand);
			
			commandMap.mapSignal(signalBus.signal(BalanceEvent.LOAD), BalanceCommand);
			commandMap.mapSignal(signalBus.signal(StateTableConfigEvent.LOAD), StateTableConfigCommand);
			//commandMap.mapSignal(signalBus.signal(PlayersEvent.LOAD), PlayersCommand);
			//commandMap.mapSignal(signalBus.signal(WinnersEvent.LOAD), WinnersCommand);
			//commandMap.mapSignal(signalBus.signal(StatisticsEvent.LOAD), StatisticsCommand);
			
			//commandMap.mapSignal(signalBus.signal(ChatEvent.LOAD_CONFIG), ChatConfigCommand);
			//commandMap.mapSignal(signalBus.signal(ChatEvent.CONNECT), ChatConnectionCommand);
			//commandMap.mapSignal(signalBus.signal(ChatEvent.PROCESS_MESSAGE), ChatReceiveMessageCommand);
			//commandMap.mapSignal(signalBus.signal(ChatEvent.SEND_MESSAGE), ChatSendMessageCommand);
			
			commandMap.mapSignal(signalBus.signal(SocketEvent.CONNECT_GAME), SocketConnectionCommand);
			commandMap.mapSignal(signalBus.signal(VideoEvent.CONNECT), VideoConnectionCommand);
			
			commandMap.mapSignal(signalBus.signal(BetEvent.SEND_BETS), BetsCommand);
			commandMap.mapSignal(signalBus.signal(UIEvent.SETUP_ASSET), SetupAssetCommand);
			commandMap.mapSignal(signalBus.signal(UIEvent.SETUP_VIEWS), SetupViewCommand,true);
			commandMap.mapSignal(signalBus.signal(UIEvent.SETUP_LAYOUT), SetupLayoutCommand);
			commandMap.mapSignal(signalBus.signal(TaskbarActionEvent.HELP_CLICKED), HelpSWFCommand);
			commandMap.mapSignal(signalBus.signal(TaskbarActionEvent.HISTORY_CLICKED), HistorySWFCommand);
		}
	}
}