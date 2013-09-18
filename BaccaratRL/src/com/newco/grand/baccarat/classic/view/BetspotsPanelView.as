package com.newco.grand.baccarat.classic.view
{
	import com.newco.grand.baccarat.classic.model.BaccaratConstants;
	import com.newco.grand.core.common.view.Betchip;
	import com.newco.grand.core.common.view.interfaces.IUIView;
	import com.newco.grand.core.utils.GameUtils;
	import com.smart.uicore.controls.ScrollPane;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class BetspotsPanelView extends MovieClip implements IUIView
	{
		protected var _display:*;
		private var scrollPane:ScrollPane;
		
		public var makeBetSignal:Signal=new Signal();

		private var chipHolder:MovieClip=new MovieClip();
		
		public function BetspotsPanelView()
		{
			super();
			initDisplay();
			scrollPane = new ScrollPane();
			scrollPane.scrollDrag=false;
			//scrollPane.addView(betspotsPanelAsset);
			_display.addChild(chipHolder);
			chipHolder.mouseEnabled= false;
			chipHolder.mouseChildren=false;
			//addChild(scrollPane);

		}
		public function initDisplay():void{
			_display= new BetspotsPanelAsset();
			addChild(_display);
		}
		public function get view():*{
			return _display;
		}
		
		public function updateLanguage():void{
			
		}
		public function init():void
		{
			scrollPane.y=10;
			_display.spot_player.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
			_display.spot_tie.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
			_display.spot_banker.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
			_display.spot_pair_player.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
			_display.spot_pair_banker.addEventListener(MouseEvent.CLICK,doMakeBetEvent);
		}
		
		public function setMode(mode:String="pairs"):void{
			var label:String;
			switch (mode){
				case BaccaratConstants.TYPE_CLASSIC:
					label=mode;
					_display.spot_pair_player.visible=false;
					_display.spot_pair_banker.visible=false;
					break;
				case BaccaratConstants.TYPE_DRAGONTIGER:
					_display.spot_pair_player.visible=false;
					_display.spot_pair_banker.visible=false;
					label=mode;
					break;
				case BaccaratConstants.TYPE_PAIRS:
					label=mode;
					break;
				default:
					_display.spot_pair_player.visible=false;
					_display.spot_pair_banker.visible=false;
					label=BaccaratConstants.TYPE_CLASSIC;
					break;
			}
			enabledBetting(false);
		}
		
		public function clearBets():void{
			GameUtils.removeChildren(chipHolder);
		}
		
		public function enabledBetting(val:Boolean):void{
			_display.spot_player.enabled=val;
			_display.spot_tie.enabled=val;
			_display.spot_banker.enabled=val;
			_display.spot_pair_player.enabled=val;
			_display.spot_pair_banker.enabled=val;
			
			_display.spot_player.mouseEnabled=val;
			_display.spot_tie.mouseEnabled=val;
			_display.spot_banker.mouseEnabled=val;
			_display.spot_pair_player.mouseEnabled=val;
			_display.spot_pair_banker.mouseEnabled=val;
			
			_display.spot_player.buttonMode=val;
			_display.spot_tie.buttonMode=val;
			_display.spot_banker.buttonMode=val;
			_display.spot_pair_player.buttonMode=val;
			_display.spot_pair_banker.buttonMode=val;
			var label:String="off";
			if (val==true)
				label="on";
			
			_display.spot_player.gotoAndStop(label);
			_display.spot_tie.gotoAndStop(label);
			_display.spot_banker.gotoAndStop(label);
			_display.spot_pair_player.gotoAndStop(label);
			_display.spot_pair_banker.gotoAndStop(label);
			
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
					mc= _display.spot_player;
					break;
				case BaccaratConstants.TIE:
					mc= _display.spot_tie;
					break;
				case BaccaratConstants.BANKER:
					mc= _display.spot_banker;
					break;
				case BaccaratConstants.PAIRPLAYER:
					mc= _display.spot_pair_player;
					break;
				case BaccaratConstants.PAIRBANKER:
					mc= _display.spot_pair_banker;
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