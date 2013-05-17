package
{
	import com.ai.baccarat.configs.BaccaratBundle;
	import com.ai.baccarat.configs.BaccaratConfig;
	import com.smart.uicore.controls.ToolTip;
	import com.smart.uicore.controls.managers.SkinLoader;
	import com.smart.uicore.ui.UI;
	
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
			UI.init(this.stage,24);
			ToolTip.setDefaultToolTipStyle(0,0xFFFFFF,0xDDDDDD,1,1,0x666666,0.5);
			SkinLoader.loadSkinFile("skins/skin.swf",start,null,null);
		}
		
		private function start():void{
			context = new Context()
				.install(BaccaratBundle)
				.configure(
					BaccaratConfig,
					new ContextView(this)
				);
		}
	}
}