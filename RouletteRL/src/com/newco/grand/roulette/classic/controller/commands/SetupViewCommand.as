package com.newco.grand.roulette.classic.controller.commands
{
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.SignalBus;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.core.common.view.ErrorMessageView;
	import com.newco.grand.core.common.view.LoginView;
	import com.newco.grand.core.common.view.StageView;
	import com.newco.grand.core.common.view.TaskbarView;
	import com.newco.grand.core.common.view.interfaces.IAccordion;
	import com.newco.grand.core.common.view.interfaces.IChatView;
	import com.newco.grand.core.common.view.interfaces.IErrorMessageView;
	import com.newco.grand.core.common.view.interfaces.IGameStatusView;
	import com.newco.grand.core.common.view.interfaces.ILoginView;
	import com.newco.grand.core.common.view.interfaces.IStageView;
	import com.newco.grand.core.common.view.interfaces.ITaskbarView;
	import com.newco.grand.core.common.view.interfaces.IVideoView;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.view.AccordionUIView;
	import com.newco.grand.roulette.classic.view.BetSpotsView;
	import com.newco.grand.roulette.classic.view.ChatView;
	import com.newco.grand.roulette.classic.view.GameStatusView;
	import com.newco.grand.roulette.classic.view.LimitsView;
	import com.newco.grand.roulette.classic.view.LobbyView;
	import com.newco.grand.roulette.classic.view.ResultsClassicView;
	import com.newco.grand.roulette.classic.view.VideoView;
	import com.newco.grand.roulette.classic.view.interfaces.IBetSpotsView;
	import com.newco.grand.roulette.classic.view.interfaces.ILimitsView;
	import com.newco.grand.roulette.classic.view.interfaces.ILobbyView;
	import com.newco.grand.roulette.classic.view.interfaces.IResultsClassicView;
	
	import org.assetloader.core.IAssetLoader;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IInjector;



	public class SetupViewCommand extends BaseCommand
	{
		[Inject]

		public var service:IAssetLoader;

		[Inject]
		public var urls:URLSModel;

		[Inject]
		public var contextView:ContextView;

		[Inject]
		public var flashVars:FlashVars;
		
		[Inject]
		public var signalBus:SignalBus;
		
		[Inject]
		public var injector:IInjector;
		public function SetupViewCommand()
		{
			super();
		}

		override public function execute():void {
			setupView();
		}

		private function setupView():void {
			injector.map(IStageView).toValue(contextView.view.addChild(new StageView()));
			injector.map(ILoginView).toValue(contextView.view.addChild(new LoginView()));
			injector.map(IBetSpotsView).toValue(contextView.view.addChild(new BetSpotsView()));
			injector.map(IAccordion).toValue(contextView.view.addChild(new AccordionUIView()));

			injector.map(IGameStatusView).toValue(contextView.view.addChild(new GameStatusView()));
			injector.map(IChatView).toValue(contextView.view.addChild(new ChatView()));
			injector.map(IResultsClassicView).toValue(contextView.view.addChild(new ResultsClassicView()));
			injector.map(IVideoView).toValue(contextView.view.addChild(new VideoView()));
			injector.map(ILimitsView).toValue(contextView.view.addChild(new LimitsView()));
			injector.map(ITaskbarView).toValue(contextView.view.addChild(new TaskbarView()));
			injector.map(ILobbyView).toValue(contextView.view.addChild(new LobbyView()));
			
			
			//injector.map(ITaskbarView).toValue(contextView.view.addChild(new MessageBoxView()));
			//contextView.view.addChild(new MessageBoxView());

			//contextView.addChild(new StageInfoView());
			
			/*contextView.view.addChild(new StageView());
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
			*/
			if (FlashVars.DEBUG_MODE==true)
				injector.map(IErrorMessageView).toValue(contextView.view.addChild(new ErrorMessageView()));
				
		}

		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}

