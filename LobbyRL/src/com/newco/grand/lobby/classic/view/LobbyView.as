package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.core.common.view.SMButton;
	import com.newco.grand.lobby.classic.model.LobbyModel;
	import com.newco.grand.lobby.classic.model.TableModel;
	import com.smart.uicore.controls.Button;
	
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;
	
	import org.osflash.signals.Signal;

	public class LobbyView extends Sprite
	{
		public var tablesLayer:MovieClip=new MovieClip();
		
		private var _count:int=0;
		
	
		private var bottomPanel:BottomPanelAsset;
		
		//public var rouletteBtn:SMButton;
		//public var baccaratBtn:SMButton;
		//public var blackjackBtn:SMButton;
		
		public var gameChangeSignal:Signal=new Signal();
		
		public var loadHistorySignal:Signal=new Signal();
		public var loadHelpSignal:Signal=new Signal();
		public var doBackSignal:Signal=new Signal();

		public var historyBtn:SMButton;
		public var helpBtn:SMButton;
		public var backBtn:SMButton;
	
		public function LobbyView()
		{
		
			bottomPanel=new BottomPanelAsset();
			addChild(bottomPanel);

			addChild(tablesLayer);
			backBtn=new SMButton(bottomPanel.backBtn);
			backBtn.label="BACK";
			backBtn.visible=false;
			historyBtn=new SMButton(bottomPanel.historyBtn);
			historyBtn.skin.addEventListener(MouseEvent.CLICK,doOpenHistory);
			
			helpBtn=new SMButton(bottomPanel.helpBtn);
			helpBtn.skin.addEventListener(MouseEvent.CLICK,doOpenHelp);
			backBtn.skin.addEventListener(MouseEvent.CLICK,doBackEvent);
			

		}
		public function doCloseEvent(evt:MouseEvent):void{
			backBtn.visible=false;
			doBackSignal.dispatch();
		}	
		public function doBackEvent(evt:MouseEvent):void{
			backBtn.visible=false;
			doBackSignal.dispatch();
		}
		public function doOpenHistory(evt:MouseEvent):void{
			loadHistorySignal.dispatch();
		}
		public function doOpenHelp(evt:MouseEvent):void{
			loadHelpSignal.dispatch();
		}
		
		
		public function doChangeGame(evt:MouseEvent):void{
			var target:SimpleButton=evt.target as SimpleButton;
			switch (target.name)
			{
				case "rouletteBtn":
					gameChangeSignal.dispatch("Roulette");
					break;
				case "baccaratBtn":
					gameChangeSignal.dispatch("Baccarat");
					break;
				case "blackjackBtn":
					gameChangeSignal.dispatch("Blackjack");
					break;
			}
			
	
			trace(target.name);
		}

		public function setBalance(val:String):void{
			bottomPanel.balanceMC.value.text=String(val);
		}
		
		public function get count():int{
			return _count;
		}
		
		public function set count(val:int):void{
			 _count=val;

		}
		
		
	}
}