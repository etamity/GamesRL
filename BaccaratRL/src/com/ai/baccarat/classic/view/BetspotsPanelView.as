package com.ai.baccarat.classic.view
{
	import com.ai.baccarat.classic.model.BaccaratConstants;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.view.Betchip;
	import com.ai.core.view.interfaces.IUIView;
	import com.smart.uicore.controls.ScrollPane;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class BetspotsPanelView extends MovieClip implements IUIView
	{
		private var betspotsPanelAsset:BetspotsPanelAsset;
		private var scrollPane:ScrollPane;
		
		public var makeBetSignal:Signal=new Signal();

		private var chipHolder:MovieClip=new MovieClip();
		
		public function BetspotsPanelView()
		{
			super();
			betspotsPanelAsset= new BetspotsPanelAsset();
			scrollPane = new ScrollPane();
			scrollPane.scrollDrag=false;
			//scrollPane.addView(betspotsPanelAsset);
			betspotsPanelAsset.addChild(chipHolder);
			chipHolder.mouseEnabled= false;
			chipHolder.mouseChildren=false;
			//addChild(scrollPane);
			addChild(betspotsPanelAsset);
		}

		public function init():void
		{
			scrollPane.y=10;
			betspotsPanelAsset.spot_player.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
			betspotsPanelAsset.spot_tie.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
			betspotsPanelAsset.spot_banker.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
			betspotsPanelAsset.spot_pair_player.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
			betspotsPanelAsset.spot_pair_banker.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
		}
		
		public function setMode(mode:String="pairs"):void{
			var label:String;
			switch (mode){
				case BaccaratConstants.TYPE_CLASSIC:
					label=mode;
					betspotsPanelAsset.spot_pair_player.visible=false;
					betspotsPanelAsset.spot_pair_banker.visible=false;
					break;
				case BaccaratConstants.TYPE_DRAGONTIGER:
					betspotsPanelAsset.spot_pair_player.visible=false;
					betspotsPanelAsset.spot_pair_banker.visible=false;
					label=mode;
					break;
				case BaccaratConstants.TYPE_PAIRS:
					label=mode;
					break;
				default:
					betspotsPanelAsset.spot_pair_player.visible=false;
					betspotsPanelAsset.spot_pair_banker.visible=false;
					label=BaccaratConstants.TYPE_CLASSIC;
					break;
			}
			enabledBetting(false);
		}
		
		public function clearBets():void{
			GameUtils.removeChildren(chipHolder);
		}
		
		public function enabledBetting(val:Boolean):void{
			betspotsPanelAsset.spot_player.enabled=val;
			betspotsPanelAsset.spot_tie.enabled=val;
			betspotsPanelAsset.spot_banker.enabled=val;
			betspotsPanelAsset.spot_pair_player.enabled=val;
			betspotsPanelAsset.spot_pair_banker.enabled=val;
			
			betspotsPanelAsset.spot_player.mouseEnabled=val;
			betspotsPanelAsset.spot_tie.mouseEnabled=val;
			betspotsPanelAsset.spot_banker.mouseEnabled=val;
			betspotsPanelAsset.spot_pair_player.mouseEnabled=val;
			betspotsPanelAsset.spot_pair_banker.mouseEnabled=val;
			
			betspotsPanelAsset.spot_player.buttonMode=val;
			betspotsPanelAsset.spot_tie.buttonMode=val;
			betspotsPanelAsset.spot_banker.buttonMode=val;
			betspotsPanelAsset.spot_pair_player.buttonMode=val;
			betspotsPanelAsset.spot_pair_banker.buttonMode=val;
			var label:String="off";
			if (val==true)
				label="on";
			
			betspotsPanelAsset.spot_player.gotoAndStop(label);
			betspotsPanelAsset.spot_tie.gotoAndStop(label);
			betspotsPanelAsset.spot_banker.gotoAndStop(label);
			betspotsPanelAsset.spot_pair_player.gotoAndStop(label);
			betspotsPanelAsset.spot_pair_banker.gotoAndStop(label);
			
		}
		
		private function doMakeBetEvent(evt:MouseEvent):void{
			var target:MovieClip= (evt.target as MovieClip);
			var targetName:String= (evt.target as MovieClip).name;
			switch (targetName){
				case "spot_player":
					makeBetSignal.dispatch(BaccaratConstants.PLAYER);
					break;
				case "spot_tie":
					makeBetSignal.dispatch(BaccaratConstants.TIE);
					break;
				case "spot_banker":
					makeBetSignal.dispatch(BaccaratConstants.BANKER);
					break;
				case "spot_pair_player":
					makeBetSignal.dispatch(BaccaratConstants.PAIRPLAYER);
					break;
				case "spot_pair_banker":
					makeBetSignal.dispatch(BaccaratConstants.PAIRBANKER);
					break;
			}
			
		}
		
		public function makeBet(value:Number,side:String):void{
			var mc:MovieClip;
			switch (side){
				case BaccaratConstants.PLAYER:
					mc= betspotsPanelAsset.spot_player;
					break;
				case BaccaratConstants.TIE:
					mc= betspotsPanelAsset.spot_tie;
					break;
				case BaccaratConstants.BANKER:
					mc= betspotsPanelAsset.spot_banker;
					break;
				case BaccaratConstants.PAIRPLAYER:
					mc= betspotsPanelAsset.spot_pair_player;
					break;
				case BaccaratConstants.PAIRBANKER:
					mc= betspotsPanelAsset.spot_pair_banker;
					break;
			}
			var chip:Betchip= new Betchip();
			chip.chipValue= value;
			chip.x=mc.x-chip.width/2;
			chip.y=mc.y-chip.height/2;
			chip.updateChipColor(value);
			chipHolder.addChild(chip);
		}
		
		public function align():void
		{
		}
		public function resize(width:Number,height:Number):void{
			scrollPane.setSize(width,height);
			scrollPane.updateViewSize(this.width,this.height);
		}
		public function setSize(newWidth:Number, newHeight:Number):void
		{
		}
	}
}