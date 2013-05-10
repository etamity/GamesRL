package
{
	import com.ai.baccarat.Baccarat;
	import com.ai.baccarat.configs.BaccaratBundle;
	import com.ai.baccarat.configs.BaccaratConfig;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;
	
	[SWF(width = "990", height = "610", frameRate = "24", backgroundColor = "#333333")]
	public class BaccaratRL extends Sprite
	{

		protected var context:IContext; 
		public function BaccaratRL()
		{
			addEventListener(Event.ADDED_TO_STAGE,onAddToStage);
		}
		
		private function onAddToStage(evt:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,onAddToStage);
			
			context = new Context()
				.install(BaccaratBundle)
				.configure(
					BaccaratConfig,
					new ContextView(this)
				);
			context.afterInitializing(function():void{	
				var baccarat:Baccarat=new Baccarat();
			});
		}
	}
}