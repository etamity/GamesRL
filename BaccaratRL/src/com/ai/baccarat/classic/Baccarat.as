package com.ai.baccarat.classic
{
	import com.ai.baccarat.classic.view.AnimationPanelView;
	import com.ai.baccarat.classic.view.BetSpotsView;
	import com.ai.baccarat.classic.view.CardsPanelView;
	import com.ai.baccarat.classic.view.ScoreCardView;
	import com.ai.baccarat.classic.view.TableGraphicView;
	import com.ai.core.model.Actor;
	import com.ai.core.model.SignalBus;
	import com.ai.core.model.SignalConstants;
	import com.ai.core.view.ChatView;
	import com.ai.core.view.GameStatusView;
	import com.ai.core.view.LoginView;
	import com.ai.core.view.MessageBoxView;
	import com.ai.core.view.StageView;
	import com.ai.core.view.TaskbarView;
	import com.ai.core.view.VideoView;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	
	public class Baccarat
	{
		
		[Inject]
		public var contextView:ContextView;
		
		[Inject]
		public var signalBus:SignalBus;

		
		public function Baccarat()
		{
			init();
		}
		public function init():void{
			signalBus.dispatch(SignalConstants.STARTUP);
			//setupViews();
			
		}
		
		public function setupViews():void{
			contextView.view.addChild(new StageView());
			contextView.view.addChild(new TableGraphicView());
			contextView.view.addChild(new LoginView());
			contextView.view.addChild(new TaskbarView());
			contextView.view.addChild(new GameStatusView())
			contextView.view.addChild(new ChatView());
			
			var video:VideoView=new VideoView();
			//video.showFullSize=true;
			contextView.view.addChild(video);
			contextView.view.addChild(new BetSpotsView());
			contextView.view.addChild(new CardsPanelView());
			contextView.view.addChild(new AnimationPanelView());
			contextView.view.addChild(new ScoreCardView());
			contextView.view.addChild(new MessageBoxView());
			
		}
		
	}
}