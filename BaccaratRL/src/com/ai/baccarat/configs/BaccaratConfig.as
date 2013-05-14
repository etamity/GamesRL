package com.ai.baccarat.configs
{
	import com.ai.baccarat.controller.commands.SetupViewCommand;
	import com.ai.baccarat.controller.commands.StateTableConfigCommand;
	import com.ai.baccarat.model.GameDataModel;
	import com.ai.baccarat.service.AnimationService;
	import com.ai.baccarat.service.GameSocketService;
	import com.ai.baccarat.view.AnimationPanelView;
	import com.ai.baccarat.view.BetSpotsView;
	import com.ai.baccarat.view.CardsPanelView;
	import com.ai.baccarat.view.ScoreCardView;
	import com.ai.baccarat.view.mediators.AnimationMeditor;
	import com.ai.baccarat.view.mediators.BetSpotsMediator;
	import com.ai.baccarat.view.mediators.CardsPanelMediator;
	import com.ai.baccarat.view.mediators.ScoreCardMediator;
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
	import com.ai.core.view.MessageBoxView;
	import com.ai.core.view.StageView;
	import com.ai.core.view.TaskbarView;
	import com.ai.core.view.VideoView;
	import com.ai.core.view.mediators.AccordionMediator;
	import com.ai.core.view.mediators.ChatMediator;
	import com.ai.core.view.mediators.GameStatusMediator;
	import com.ai.core.view.mediators.LoginMediator;
	import com.ai.core.view.mediators.MessageBoxMediator;
	import com.ai.core.view.mediators.StageMediator;
	import com.ai.core.view.mediators.TaskbarMediator;
	import com.ai.core.view.mediators.VideoMediator;
	
	import org.assetloader.AssetLoader;
	import org.assetloader.core.IAssetLoader;
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
		
		public function configure():void
		{      
			context.logLevel = LogLevel.DEBUG;
			gameData.game=Constants.BACCARAT;
			mapSingletons();
			mapMediators();
			mapCommands();
			
			context.afterInitializing(init);
		}
		
		public function init():void{
			mediatorMap.mediate(contextView.view);
			signalBus.dispatch(SignalConstants.STARTUP);
		}
	
		public function mapSingletons():void{
			injector.map(FlashVars).toValue(new FlashVars(contextView));
			injector.map(IAssetLoader).toSingleton(AssetLoader);
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
			mediatorMap.map(AccordionView).toMediator(AccordionMediator);
			mediatorMap.map(ChatView).toMediator(ChatMediator);
			mediatorMap.map(VideoView).toMediator(VideoMediator);
			mediatorMap.map(BetSpotsView).toMediator(BetSpotsMediator);
			mediatorMap.map(CardsPanelView).toMediator(CardsPanelMediator);
			mediatorMap.map(AnimationPanelView).toMediator(AnimationMeditor);
			mediatorMap.map(ScoreCardView).toMediator(ScoreCardMediator);
			mediatorMap.map(MessageBoxView).toMediator(MessageBoxMediator);
		}
		public function mapCommands():void{
		/*	commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP)).toCommand(StartupCommand);
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP_COMPLETE)).toCommand(StartupCompleteCommand);
			commandMap.mapSignal(signalBus.signal(LoginEvent.LOGIN)).toCommand(FBLoginCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.SEAT)).toCommand(SeatCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.LOAD)).toCommand(StartupDataCommand);
			commandMap.mapSignal(signalBus.signal(BalanceEvent.LOAD)).toCommand(BalanceCommand);
			commandMap.mapSignal(signalBus.signal(StateTableConfigEvent.LOAD)).toCommand(StateTableConfigCommand);
			commandMap.mapSignal(signalBus.signal(PlayersEvent.LOAD)).toCommand(PlayersCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.LOAD_CONFIG)).toCommand(ChatConfigCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.CONNECT)).toCommand(ChatConnectionCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.PROCESS_MESSAGE)).toCommand(ChatReceiveMessageCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.SEND_MESSAGE)).toCommand(ChatSendMessageCommand);
			commandMap.mapSignal(signalBus.signal(SocketEvent.CONNECT_GAME)).toCommand(SocketConnectionCommand);
			commandMap.mapSignal(signalBus.signal(VideoEvent.CONNECT)).toCommand(VideoConnectionCommand);
			
			commandMap.mapSignal(signalBus.signal(BetEvent.SEND_BETS)).toCommand(BetsCommand);
			commandMap.mapSignal(signalBus.signal(UIEvent.SETUP_VIEWS)).toCommand(SetupViewCommand);*/
			
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP), StartupCommand, true);
			commandMap.mapSignal(signalBus.signal(SignalConstants.STARTUP_COMPLETE), StartupCompleteCommand, true);
			commandMap.mapSignal(signalBus.signal(LoginEvent.LOGIN), FBLoginCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.SEAT), SeatCommand);
			commandMap.mapSignal(signalBus.signal(StartupDataEvent.LOAD), StartupDataCommand);
			commandMap.mapSignal(signalBus.signal(BalanceEvent.LOAD), BalanceCommand);
			commandMap.mapSignal(signalBus.signal(StateTableConfigEvent.LOAD), StateTableConfigCommand);
			commandMap.mapSignal(signalBus.signal(PlayersEvent.LOAD), PlayersCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.LOAD_CONFIG), ChatConfigCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.CONNECT), ChatConnectionCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.PROCESS_MESSAGE), ChatReceiveMessageCommand);
			commandMap.mapSignal(signalBus.signal(ChatEvent.SEND_MESSAGE), ChatSendMessageCommand);
			commandMap.mapSignal(signalBus.signal(SocketEvent.CONNECT_GAME), SocketConnectionCommand);
			commandMap.mapSignal(signalBus.signal(VideoEvent.CONNECT), VideoConnectionCommand);
			
			commandMap.mapSignal(signalBus.signal(BetEvent.SEND_BETS), BetsCommand);
			commandMap.mapSignal(signalBus.signal(UIEvent.SETUP_VIEWS), SetupViewCommand);
			
		}
	}
}