package
{
	import com.newco.grand.roulette.configs.FBRouletteConfig;
	import com.newco.grand.roulette.configs.RouletteBundle;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	public class RouletteFB extends Sprite
	{
		[SWF(width = "760", height = "890", frameRate = "24", backgroundColor = "#000000")]
		
		protected var context:IContext; 
		public function RouletteFB()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		private function onAddToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			context = new Context()
				.install(RouletteBundle)
				.configure(
					FBRouletteConfig,
					new ContextView(this)
				);
		}
	}
}