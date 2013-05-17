package com.ai.baccarat.configs
{
	import com.ai.baccarat.classic.controller.commands.SetupViewCommand;
	import com.ai.baccarat.classic.controller.commands.StateTableConfigCommand;
	import com.ai.baccarat.classic.model.GameDataModel;
	import com.ai.baccarat.classic.service.AnimationService;
	import com.ai.baccarat.classic.service.GameSocketService;
	import com.ai.baccarat.classic.view.AnimationPanelView;
	import com.ai.baccarat.classic.view.BetSpotsView;
	import com.ai.baccarat.classic.view.BetspotsPanelView;
	import com.ai.baccarat.classic.view.CardsPanelView;
	import com.ai.baccarat.classic.view.ScoreCardView;
	import com.ai.baccarat.classic.view.TableGraphicView;
	import com.ai.baccarat.classic.view.mediators.AnimationMeditor;
	import com.ai.baccarat.classic.view.mediators.BaccaratAccordionMediator;
	import com.ai.baccarat.classic.view.mediators.BetSpotsMediator;
	import com.ai.baccarat.classic.view.mediators.BetspotsPanelMediator;
	import com.ai.baccarat.classic.view.mediators.CardsPanelMediator;
	import com.ai.baccarat.classic.view.mediators.ScoreCardMediator;
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
	import com.ai.core.controller.commands.WinnersCommand;
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
	import com.ai.core.controller.signals.WinnersEvent;
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
	import com.ai.core.view.ChatView;
	import com.ai.core.view.GameStatusView;
	import com.ai.core.view.LoginView;
	import com.ai.core.view.MessageBoxView;
	import com.ai.core.view.StageView;
	import com.ai.core.view.TaskbarView;
	import com.ai.core.view.VideoView;
	import com.ai.core.view.interfaces.IAccordion;
	import com.ai.core.view.mediators.ChatMediator;
	import com.ai.core.view.mediators.GameStatusMediator;
	import com.ai.core.view.mediators.LoginMediator;
	import com.ai.core.view.mediators.MessageBoxMediator;
	import com.ai.core.view.mediators.PlayersMediator;
	import com.ai.core.view.mediators.StageMediator;
	import com.ai.core.view.mediators.TaskbarMediator;
	import com.ai.core.view.mediators.VideoMediator;
	import com.ai.core.view.mediators.WinnersMediator;
	import com.ai.core.view.uicomps.AccordionUIView;
	import com.ai.core.view.uicomps.PlayersUIView;
	import com.ai.core.view.uicomps.WinnersUIView;
	
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


	public class BaccaratConfig implements IConfig
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
		protected var service:IAssetLoader;
		
		public function configure():void
		{      
			context.logLevel = LogLevel.DEBUG;

			createInstance();
			mapSingletons();
			mapMediators();
			mapCommands();
			
			context.afterInitializing(init);
		}
		public function setupViews():void{
			contextView.view.addChild(new StageView());
			contextView.view.addChild(new VideoView());
			contextView.view.addChild(new TableGraphicView());
			contextView.view.addChild(new LoginView());
			contextView.view.addChild(new AccordionUIView());
			contextView.view.addChild(new TaskbarView());
			contextView.view.addChild(new GameStatusView())
			contextView.view.addChild(new ChatView());
			contextView.view.addChild(new BetSpotsView());
			contextView.view.addChild(new CardsPanelView());
			contextView.view.addChild(new AnimationPanelView());
			contextView.view.addChild(new ScoreCardView());
			//contextView.view.addChild(new MessageBoxView());
			
		}
		public function createInstance():void{
			gameData.game=Constants.BACCARAT;
			gameData.gameType=Constants.TYPE_CLASSIC;
			
			service=injector.getOrCreateNewInstance(AssetLoader);
			var param:IParam=new Param(Param.PREVENT_CACHE, true);
			service.addParam(param);
		}
		public function init():void{
			mediatorMap.mediate(contextView.view);
			signalBus.dispatch(SignalConstants.STARTUP);
			setupViews();
		}
	
		public function mapSingletons():void{
			injector.map(FlashVars).toValue(new FlashVars(contextView));
			injector.map(IAssetLoader).toValue(service);
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
			injector.map(AnimationService).asSingleton();
		}
		public function mapMediators():void{
			
			mediatorMap.map(StageView).toMediator(StageMediator);
			mediatorMap.map(LoginView).toMediator(LoginMediator);
			mediatorMap.map(TaskbarView).toMediator(TaskbarMediator);
			mediatorMap.map(GameStatusView).toMediator(GameStatusMediator);
			mediatorMap.map(IAccordion).toMediator(BaccaratAccordionMediator);
			mediatorMap.map(ChatView).toMediator(ChatMediator);
			mediatorMap.map(VideoView).toMediator(VideoMediator);
			mediatorMap.map(BetSpotsView).toMediator(BetSpotsMediator);
			mediatorMap.map(CardsPanelView).toMediator(CardsPanelMediator);
			mediatorMap.map(AnimationPanelView).toMediator(AnimationMeditor);
			mediatorMap.map(ScoreCardView).toMediator(ScoreCardMediator);
			mediatorMap.map(MessageBoxView).toMediator(MessageBoxMediator);
			mediatorMap.map(BetspotsPanelView).toMediator(BetspotsPanelMediator);
			mediatorMap.map(PlayersUIView).toMediator(PlayersMediator);
			mediatorMap.map(WinnersUIView).toMediator(WinnersMediator);
		}
		public function mapCommands():void{

			
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP), StartupCommand, true);
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP_COMPLETE), StartupCompleteCommand, true);
			commandMap.mapSignal(signalBus.signal(LoginEvent.LOGIN), FBLoginCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.SEAT), SeatCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.LOAD), StartupDataCommand);
			commandMap.mapSignal(signalBus.signal(BalanceEvent.LOAD), BalanceCommand);
			commandMap.mapSignal(signalBus.signal(StateTableConfigEvent.LOAD), StateTableConfigCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.LOAD_CONFIG), ChatConfigCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.CONNECT), ChatConnectionCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.PROCESS_MESSAGE), ChatReceiveMessageCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.SEND_MESSAGE), ChatSendMessageCommand);
			commandMap.mapSignal(signalBus.signal(SocketEvent.CONNECT_GAME), SocketConnectionCommand);
			commandMap.mapSignal(signalBus.signal(VideoEvent.CONNECT), VideoConnectionCommand);
			commandMap.mapSignal(signalBus.signal(PlayersEvent.LOAD), PlayersCommand);
			commandMap.mapSignal(signalBus.signal(WinnersEvent.LOAD), WinnersCommand);
			commandMap.mapSignal(signalBus.signal(BetEvent.SEND_BETS), BetsCommand);
			commandMap.mapSignal(signalBus.signal(UIEvent.SETUP_VIEWS), SetupViewCommand);
			
		}
	}
}