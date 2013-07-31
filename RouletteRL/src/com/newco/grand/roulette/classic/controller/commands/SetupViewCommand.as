package com.newco.grand.roulette.classic.controller.commands
{
	import com.newco.grand.core.common.controller.commands.BaseCommand;
	import com.newco.grand.core.common.model.FlashVars;
	import com.newco.grand.core.common.model.URLSModel;
	import com.newco.grand.roulette.classic.view.ChatView;
	import com.newco.grand.roulette.classic.view.GameStatusView;
	import com.newco.grand.core.common.view.LoginView;
	import com.newco.grand.core.common.view.StageView;
	import com.newco.grand.core.common.view.TaskbarView;
	import com.newco.grand.roulette.classic.view.VideoView;
	import com.newco.grand.roulette.classic.view.AccordionUIView;
	import com.newco.grand.core.utils.GameUtils;
	import com.newco.grand.roulette.classic.view.BetSpotsView;
	import com.newco.grand.roulette.classic.view.LimitsView;
	import com.newco.grand.roulette.classic.view.LobbyView;
	import com.newco.grand.roulette.classic.view.ResultsClassicView;
	
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
		
		[Inject]
		public var flashVars:FlashVars;
		
		public function SetupViewCommand()
		{
			super();
		}
		
		override public function execute():void {
			setupView();
		}
		
		private function setupView():void {
			contextView.view.addChild(new StageView());
			contextView.view.addChild(new LoginView());
		
			contextView.view.addChild(new BetSpotsView());
			contextView.view.addChild(new AccordionUIView());
			contextView.view.addChild(new LimitsView());
			contextView.view.addChild(new GameStatusView());
			contextView.view.addChild(new ChatView());
			contextView.view.addChild(new ResultsClassicView());
			contextView.view.addChild(new VideoView());
			contextView.view.addChild(new TaskbarView());
			//contextView.view.addChild(new MessageBoxView());
			contextView.view.addChild(new LobbyView());
			//contextView.addChild(new StageInfoView());
			
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}