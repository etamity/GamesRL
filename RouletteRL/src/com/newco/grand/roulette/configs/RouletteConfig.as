package com.newco.grand.roulette.configs
{
	import com.newco.grand.core.common.controller.commands.BalanceCommand;
	import com.newco.grand.core.common.controller.commands.BetsCommand;
	import com.newco.grand.core.common.controller.commands.ChatConfigCommand;
	import com.newco.grand.core.common.controller.commands.ChatConnectionCommand;
	import com.newco.grand.core.common.controller.commands.ChatReceiveMessageCommand;
	import com.newco.grand.core.common.controller.commands.ChatSendMessageCommand;
	import com.newco.grand.core.common.controller.commands.FBLoginCommand;
	import com.newco.grand.core.common.controller.commands.PlayersCommand;
	import com.newco.grand.core.common.controller.commands.SeatCommand;
	import com.newco.grand.core.common.controller.commands.SocketConnectionCommand;
	import com.newco.grand.core.common.controller.commands.StartupCommand;
	import com.newco.grand.core.common.controller.commands.StartupCompleteCommand;
	import com.newco.grand.core.common.controller.commands.StartupDataCommand;
	import com.newco.grand.core.common.controller.commands.VideoConnectionCommand;
	import com.newco.grand.core.common.controller.commands.WinnersCommand;
	import com.newco.grand.core.common.controller.signals.BalanceEvent;
	import com.newco.grand.core.common.controller.signals.BetEvent;
	import com.newco.grand.core.common.controller.signals.ChatEvent;
	import com.newco.grand.core.common.controller.signals.LoginEvent;
	import com.newco.grand.core.common.controller.signals.PlayersEvent;
	import com.newco.grand.core.common.controller.signals.SocketEvent;
	import com.newco.grand.core.common.controller.signals.StartupDataEvent;
	import com.newco.grand.core.common.controller.signals.StateTableConfigEvent;
	import com.newco.grand.core.common.controller.signals.UIEvent;
	import com.newco.grand.core.common.controller.signals.VideoEvent;
	import com.newco.grand.core.common.controller.signals.WinnersEvent;
	import com.newco.grand.core.common.model.Chat;
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.IGameData;
	import com.newco.grand.core.common.model.Player;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.SignalConstants;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.service.ChatSocketService;
	import com.newco.grand.core.common.service.ConfigService;
	import com.newco.grand.core.common.service.ISocketService;
	import com.newco.grand.core.common.service.URLSService;
	import com.newco.grand.core.common.service.VideoService;
	import com.newco.grand.core.common.service.impl.XMLService;
	import com.newco.grand.core.common.view.interfaces.IAccordion;
	import com.newco.grand.core.common.view.interfaces.IChatView;
	import com.newco.grand.core.common.view.interfaces.IGameStatusView;
	import com.newco.grand.core.common.view.interfaces.ILoginView;
	import com.newco.grand.core.common.view.interfaces.IStageView;
	import com.newco.grand.core.common.view.interfaces.ITaskbarView;
	import com.newco.grand.core.common.view.interfaces.IVideoView;
	import com.newco.grand.core.common.view.mediators.ChatMediator;
	import com.newco.grand.core.common.view.mediators.GameStatusMediator;
	import com.newco.grand.core.common.view.mediators.LoginMediator;
	import com.newco.grand.core.common.view.mediators.PlayersMediator;
	import com.newco.grand.core.common.view.mediators.StageMediator;
	import com.newco.grand.core.common.view.mediators.TaskbarMediator;
	import com.newco.grand.core.common.view.mediators.VideoMediator;
	import com.newco.grand.core.common.view.mediators.WinnersMediator;
	import com.newco.grand.core.common.view.uicomps.PlayersUIView;
	import com.newco.grand.core.common.view.uicomps.WinnersUIView;
	import com.newco.grand.roulette.classic.controller.commands.SetupAssetCommand;
	import com.newco.grand.roulette.classic.controller.commands.SetupViewCommand;
	import com.newco.grand.roulette.classic.controller.commands.StateTableConfigCommand;
	import com.newco.grand.roulette.classic.controller.commands.StatisticsCommand;
	import com.newco.grand.roulette.classic.controller.signals.StatisticsEvent;
	import com.newco.grand.roulette.classic.model.GameDataModel;
	import com.newco.grand.roulette.classic.service.GameSocketService;
	import com.newco.grand.roulette.classic.view.FavouritesBetsView;
	import com.newco.grand.roulette.classic.view.LimitsView;
	import com.newco.grand.roulette.classic.view.LobbyView;
	import com.newco.grand.roulette.classic.view.PlayersBetsView;
	import com.newco.grand.roulette.classic.view.ResultsClassicView;
	import com.newco.grand.roulette.classic.view.StageInfoView;
	import com.newco.grand.roulette.classic.view.StatisticsView;
	import com.newco.grand.roulette.classic.view.interfaces.IBetSpotsView;
	import com.newco.grand.roulette.classic.view.mediators.BetSpotsMediator;
	import com.newco.grand.roulette.classic.view.mediators.FavouritesBetsMediator;
	import com.newco.grand.roulette.classic.view.mediators.LimitsMediator;
	import com.newco.grand.roulette.classic.view.mediators.LobbyMediator;
	import com.newco.grand.roulette.classic.view.mediators.PlayersBetsMediator;
	import com.newco.grand.roulette.classic.view.mediators.ResultsClassicMediator;
	import com.newco.grand.roulette.classic.view.mediators.RouletteAccordionMediator;
	import com.newco.grand.roulette.classic.view.mediators.StageInfoMediator;
	import com.newco.grand.roulette.classic.view.mediators.StatisticsMediator;
	
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
	
	public class RouletteConfig implements IConfig
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
		
		public function RouletteConfig()
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
			injector.map(VideoService).asSingleton();
			injector.map(XMLService).asSingleton();
			injector.map(URLSModel).asSingleton();
			injector.map(Player).asSingleton();
			injector.map(Chat).asSingleton();
			injector.map(IGameData).toValue(gameData)
			injector.map(GameDataModel).toValue(gameData);
			injector.map(SignalBus).toValue(signalBus);
			injector.map(ConfigService).asSingleton();
			injector.map(URLSService).asSingleton();
			
		}
		public function mapMediators():void{
			mediatorMap.map(IStageView).toMediator(StageMediator);
			mediatorMap.map(ILoginView).toMediator(LoginMediator);
			mediatorMap.map(IBetSpotsView).toMediator(BetSpotsMediator);
			mediatorMap.map(IVideoView).toMediator(VideoMediator);
			mediatorMap.map(LimitsView).toMediator(LimitsMediator);
			mediatorMap.map(ResultsClassicView).toMediator(ResultsClassicMediator);
			mediatorMap.map(ITaskbarView).toMediator(TaskbarMediator);
			mediatorMap.map(StageInfoView).toMediator(StageInfoMediator);
			mediatorMap.map(IGameStatusView).toMediator(GameStatusMediator);
			mediatorMap.map(IChatView).toMediator(ChatMediator);
			mediatorMap.map(PlayersUIView).toMediator(PlayersMediator);
			mediatorMap.map(WinnersUIView).toMediator(WinnersMediator);
			mediatorMap.map(PlayersBetsView).toMediator(PlayersBetsMediator);
			mediatorMap.map(FavouritesBetsView).toMediator(FavouritesBetsMediator);
			mediatorMap.map(IAccordion).toMediator(RouletteAccordionMediator);
			mediatorMap.map(StatisticsView).toMediator(StatisticsMediator);
			//mediatorMap.map(MessageBoxView).toMediator(MessageBoxMediator);
			mediatorMap.map(LobbyView).toMediator(LobbyMediator);

		}
		public function mapCommands():void{
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP), StartupCommand, true);
			
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP_COMPLETE), StartupCompleteCommand, true);
			
			commandMap.mapSignal(signalBus.signal(LoginEvent.LOGIN), FBLoginCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.SEAT), SeatCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.LOAD), StartupDataCommand);
			commandMap.mapSignal(signalBus.signal(BalanceEvent.LOAD), BalanceCommand);
			commandMap.mapSignal(signalBus.signal(StateTableConfigEvent.LOAD), StateTableConfigCommand);
			commandMap.mapSignal(signalBus.signal(PlayersEvent.LOAD), PlayersCommand);
			commandMap.mapSignal(signalBus.signal(WinnersEvent.LOAD), WinnersCommand);
			commandMap.mapSignal(signalBus.signal(StatisticsEvent.LOAD), StatisticsCommand);
			
			commandMap.mapSignal(signalBus.signal(ChatEvent.LOAD_CONFIG), ChatConfigCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.CONNECT), ChatConnectionCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.PROCESS_MESSAGE), ChatReceiveMessageCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.SEND_MESSAGE), ChatSendMessageCommand);
			
			commandMap.mapSignal(signalBus.signal(SocketEvent.CONNECT_GAME), SocketConnectionCommand);
			commandMap.mapSignal(signalBus.signal(VideoEvent.CONNECT), VideoConnectionCommand);
			
			commandMap.mapSignal(signalBus.signal(BetEvent.SEND_BETS), BetsCommand);
			commandMap.mapSignal(signalBus.signal(UIEvent.SETUP_ASSET), SetupAssetCommand);
			commandMap.mapSignal(signalBus.signal(UIEvent.SETUP_VIEWS), SetupViewCommand);
		}
	}
}