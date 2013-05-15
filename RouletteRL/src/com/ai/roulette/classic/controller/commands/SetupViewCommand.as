package com.ai.roulette.classic.controller.commands
{
	import com.ai.core.controller.commands.BaseCommand;
	import com.ai.core.model.URLSModel;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.ChatView;
	import com.ai.core.view.GameStatusView;
	import com.ai.core.view.LoginView;
	import com.ai.core.view.StageView;
	import com.ai.core.view.TaskbarView;
	import com.ai.core.view.VideoView;
	import com.ai.core.view.uicomps.AccordionUIView;
	import com.ai.roulette.classic.view.BetSpotsView;
	import com.ai.roulette.classic.view.LimitsView;
	import com.ai.roulette.classic.view.LobbyView;
	import com.ai.roulette.classic.view.ResultsClassicView;
	
	import org.assetloader.core.IAssetLoader;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class SetupViewCommand extends BaseCommand
	{
		[Inject]
		
		public var service:IAssetLoader;
		
		[Inject]
		public var urls:URLSModel;
		
		[Inject]
		public var contextView:ContextView;
		public function SetupViewCommand()
		{
			super();
		}
		
		override public function execute():void {
			//setupView();
		}
		
		private function setupView():void {
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
			
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}