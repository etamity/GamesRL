package com.newco.grand.roulette.classic.controller.commands
{
	import com.ai.core.common.controller.commands.BaseCommand;
	import com.ai.core.common.model.FlashVars;
	import com.ai.core.common.model.URLSModel;
	import com.newco.grand.core.utils.GameUtils;
	com.ai.core.common.view.ChatViewhatView;
	import com.ai.core.common.view.GameStatusView;
	import com.ai.core.common.view.LoginView;
	import com.ai.core.common.view.StageView;
	import com.ai.core.common.view.TaskbarView;
	import com.ai.core.common.view.VideoView;
	import com.ai.core.common.view.uicomps.AccordionUIView;
	import com.newco.grand.roulette.classic.view.BetSpotsView;
	import com.newco.grand.roulette.classic.view.LimitsView;
	import com.newco.grand.roulette.classic.view.LobbyView;
	import com.newco.grand.roulette.classic.view.ResultsClassicView;
	import com.smart.uicore.controls.ToolTip;
	import com.smart.uicore.controls.managers.SkinLoader;
	import com.smart.uicore.ui.UI;
	
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
			contextView.view.addChild(new AccordionUIView());
			contextView.view.addChild(new BetSpotsView());
			contextView.view.addChild(new VideoView());
			contextView.view.addChild(new LimitsView());
			contextView.view.addChild(new GameStatusView());
			contextView.view.addChild(new ChatView());
			contextView.view.addChild(new ResultsClassicView());
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