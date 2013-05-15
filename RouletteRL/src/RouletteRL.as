package {
	
	import com.ai.roulette.configs.RouletteBundle;
	import com.ai.roulette.configs.RouletteConfig;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	[SWF(width = "990", height = "610", frameRate = "24", backgroundColor = "#000000")]
	public class RouletteRL extends Sprite {
		
		protected var context:IContext; 
		
		public function RouletteRL() {
		
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			//stage.align = StageAlign.TOP_LEFT;
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		private function onAddToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			context = new Context()
				.install(RouletteBundle)
				.configure(
					RouletteConfig,
					new ContextView(this)
				);
		}
	}
}