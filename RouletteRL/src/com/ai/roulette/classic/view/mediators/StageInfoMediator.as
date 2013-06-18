package com.ai.roulette.classic.view.mediators {
	
	import com.newco.grand.core.utils.GameUtils;
	import com.ai.roulette.classic.view.StageInfoView;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	
	public class StageInfoMediator extends Mediator{
		
		[Inject]
		public var view:StageInfoView;
		
		override public function initialize():void {
			view.info = "STAGE INFO\nWIDTH: " + view.stage.stageWidth + "\nHEIGHT: " + view.stage.stageHeight;
		}		
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}