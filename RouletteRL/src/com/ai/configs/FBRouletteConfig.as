package com.ai.configs
{
	import com.ai.core.controller.commands.BalanceCommand;
	import com.ai.core.controller.commands.BetsCommand;
	import com.ai.core.controller.commands.ChatConfigCommand;
	import com.ai.core.controller.commands.ChatConnectionCommand;
	import com.ai.core.controller.commands.ChatReceiveMessageCommand;
	import com.ai.core.controller.commands.ChatSendMessageCommand;
	import com.ai.core.controller.commands.FBLoginCommand;
	import com.ai.core.controller.commands.PlayersCommand;
	import com.ai.core.controller.commands.SeatCommand;
	import com.ai.core.controller.commands.SocketConnectionCommand;
	import com.ai.core.controller.commands.StartupCommand;
	import com.ai.core.controller.commands.StartupCompleteCommand;
	import com.ai.core.controller.commands.StartupDataCommand;
	import com.ai.core.controller.commands.VideoConnectionCommand;
	import com.ai.core.controller.signals.BalanceEvent;
	import com.ai.core.controller.signals.BetEvent;
	import com.ai.core.controller.signals.ChatEvent;
	import com.ai.core.controller.signals.LoginEvent;
	import com.ai.core.controller.signals.PlayersEvent;
	import com.ai.core.controller.signals.SocketEvent;
	import com.ai.core.controller.signals.StartupDataEvent;
	import com.ai.core.controller.signals.StateTableConfigEvent;
	import com.ai.core.controller.signals.UIEvent;
	import com.ai.core.controller.signals.VideoEvent;
	import com.ai.core.model.Chat;
	import com.ai.core.model.Constants;
	import com.ai.core.model.FlashVars;
	import com.ai.core.model.GameState;
	import com.ai.core.model.IGameData;
	import com.ai.core.model.Player;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.SignalConstants;
	import com.ai.core.model.URLSModel;
	import com.ai.core.service.ChatSocketService;
	import com.ai.core.service.ConfigService;
	import com.ai.core.service.ISocketService;
	import com.ai.core.service.URLSService;
	import com.ai.core.service.VideoService;
	import com.ai.core.view.AccordionView;
	import com.ai.core.view.ChatView;
	import com.ai.core.view.GameStatusView;
	import com.ai.core.view.LoginView;
	import com.ai.core.view.StageView;
	import com.ai.core.view.TaskbarView;
	import com.ai.core.view.VideoView;
	import com.ai.core.view.mediators.ChatMediator;
	import com.ai.core.view.mediators.GameStatusMediator;
	import com.ai.core.view.mediators.LoginMediator;
	import com.ai.core.view.mediators.StageMediator;
	import com.ai.core.view.mediators.TaskbarMediator;
	import com.ai.core.view.mediators.VideoMediator;
	import com.ai.roulette.controller.commands.SetupAssetCommand;
	import com.ai.roulette.controller.commands.SetupViewCommand;
	import com.ai.roulette.controller.commands.StateTableConfigCommand;
	import com.ai.roulette.controller.commands.StatisticsCommand;
	import com.ai.roulette.controller.commands.WinnersCommand;
	import com.ai.roulette.controller.signals.StatisticsEvent;
	import com.ai.core.controller.signals.WinnersEvent;
	import com.ai.roulette.model.GameDataModel;
	import com.ai.roulette.service.GameSocketService;
	import com.ai.roulette.view.BetSpotsView;
	import com.ai.roulette.view.FavouritesBetsView;
	import com.ai.roulette.view.LimitsView;
	import com.ai.roulette.view.LobbyView;
	import com.ai.roulette.view.PlayersBetsView;
	import com.ai.core.view.PlayersView;
	import com.ai.roulette.view.ResultsClassicView;
	import com.ai.roulette.view.StageInfoView;
	import com.ai.roulette.view.StatisticsView;
	import com.ai.core.view.WinnersView;
	import com.ai.roulette.view.mediators.BetSpotsMediator;
	import com.ai.roulette.view.mediators.FavouritesBetsMediator;
	import com.ai.roulette.view.mediators.LimitsMediator;
	import com.ai.roulette.view.mediators.LobbyMediator;
	import com.ai.roulette.view.mediators.PlayersBetsMediator;
	import com.ai.core.view.mediators.PlayersMediator;
	import com.ai.roulette.view.mediators.ResultsClassicMediator;
	import com.ai.roulette.view.mediators.RouletteAccordionMediator;
	import com.ai.roulette.view.mediators.StageInfoMediator;
	import com.ai.roulette.view.mediators.StatisticsMediator;
	import com.ai.core.view.mediators.WinnersMediator;
	
	import org.assetloader.AssetLoader;
	import org.assetloader.base.Param;
	import org.assetloader.core.IAssetLoader;
	import org.assetloader.core.IParam;
	import org.swiftsuspenders.Injector;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.LogLevel;
	
	public class FBRouletteConfig implements IConfig
	{	
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		[Inject]
		public var commandMap:ISignalCommandMap;
		
		[Inject]
		public var injector:Injector;
		
		[Inject]
		public var context:IContext;
		
		[Inject]
		public var contextView:ContextView;
		
		protected var gameData:GameDataModel=new GameDataModel();
		protected var signalBus:SignalBus=new SignalBus();
		protected var assetLoader:IAssetLoader;
		
		public function FBRouletteConfig()
		{
		}
		
		public function configure():void
		{      
			context.logLevel = LogLevel.DEBUG;

			createInstance();
			
			mapSingletons();
			mapMediators();
			mapCommands();
	
			context.afterInitializing(init);
			
		}
		
		public function createInstance():void{
			gameData.game=Constants.ROULETTE;
			gameData.gameType= Constants.TYPE_FACEBOOK;
			var param:IParam=new Param(Param.PREVENT_CACHE, true);
			assetLoader=injector.getOrCreateNewInstance(AssetLoader);
			assetLoader.addParam(param);
		}
		
		public function init():void{
			mediatorMap.mediate(contextView.view);
			signalBus.dispatch(SignalConstants.STARTUP);
		}
		public function mapSingletons():void{
			injector.map(FlashVars).toValue(new FlashVars(contextView));
			injector.map(IAssetLoader).toValue(assetLoader);
			injector.map(ISocketService).toSingleton(GameSocketService);
			injector.map(ChatSocketService).toSingleton(ChatSocketService);
			injector.map(VideoService).asSingleton();
			injector.map(URLSModel).asSingleton();
			injector.map(Player).asSingleton();
			injector.map(Chat).asSingleton();
			injector.map(IGameData).toValue(gameData)
			injector.map(GameDataModel).toValue(gameData);
			injector.map(SignalBus).toValue(signalBus);
			injector.map(GameState).asSingleton();
			injector.map(ConfigService).asSingleton();
			injector.map(URLSService).asSingleton();
		}
		public function mapMediators():void{
			mediatorMap.map(StageView).toMediator(StageMediator);
			mediatorMap.map(LoginView).toMediator(LoginMediator);

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