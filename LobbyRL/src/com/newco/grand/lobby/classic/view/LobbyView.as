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
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;
	
	import org.osflash.signals.Signal;

	public class LobbyView extends Sprite
	{
		public var tablesLayer:MovieClip=new MovieClip();
		
		private var _count:int=0;
		
		private var layout:LayoutAsset=new LayoutAsset();
		private var bottomPanel:BottomPanelAsset;
		
		public var rouletteBtn:SMButton;
		public var baccaratBtn:SMButton;
		public var blackjackBtn:SMButton;
		
		public var gameChangeSignal:Signal=new Signal();
		
		public var loadHistorySignal:Signal=new Signal();
		
		private var informationPanel:InfoAnimationAsset=new InfoAnimationAsset();
		
		
		public var roulette1:SMButton;
		public var roulette2:SMButton;
		public var roulette3:SMButton;
		
		public var historyBtn:SMButton;
		
		public function LobbyView()
		{
		
			bottomPanel=new BottomPanelAsset();
			addChild(bottomPanel);
			rouletteBtn=new SMButton(bottomPanel.rouletteBtn);
			baccaratBtn=new SMButton(bottomPanel.baccaratBtn);
			blackjackBtn=new SMButton(bottomPanel.blackjackBtn);
			
			addChild(informationPanel);
			addChild(tablesLayer);
			rouletteBtn.label="Roulette";
			baccaratBtn.label="Baccarat";
			blackjackBtn.label="Blackjack";
			
			
			informationPanel.x=344;
			informationPanel.y=18;
			roulette1 = new SMButton(bottomPanel.roulette1);
			roulette2 = new SMButton(bottomPanel.roulette2);
			roulette3 = new SMButton(bottomPanel.roulette3);
			rouletteBtn.skin.addEventListener(MouseEvent.CLICK,doChangeGame);
			baccaratBtn.skin.addEventListener(MouseEvent.CLICK,doChangeGame);
			blackjackBtn.skin.addEventListener(MouseEvent.CLICK,doChangeGame);
			
			historyBtn=new SMButton(bottomPanel.historyBtn);
			historyBtn.skin.addEventListener(MouseEvent.CLICK,doOpenHistory);
		}
		public function doOpenHistory(evt:MouseEvent):void{
			loadHistorySignal.dispatch();
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
		
		public function showDetial():void{
			informationPanel.gotoAndPlay(2);
		}
		public function hideDetial():void{
			informationPanel.gotoAndPlay("hide");
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
		
		public function setRoulette(lobbyModel:LobbyModel):void{
			var table:TableModel;
			var index:int =0;
			var arrBtns:Array=[roulette1,roulette2,roulette3];
			for (var i:int=0;i<lobbyModel.tables.length;i++)
			{
				table=lobbyModel.tables[i];
				if (table.game.toLowerCase()=="roulette")
				{
					if (index<3){
						
					arrBtns[index].label=table.tableName.toUpperCase();
					index++;
					}
				}
			}
		}
		
		public function addTable(mc:TableView):void{
			if (_count<4)
			{
			var pt:Point=new Point(layout.getChildByName("table"+String(_count)).x,layout.getChildByName("table"+String(_count)).y);
			tablesLayer.addChild(mc);
			mc.alpha=0;
			mc.x= (count % 2==0)?-300:1000;
			mc.y= pt.y;
	
			setTimeout(function ():void{
			Tweener.addTween(mc,{x:pt.x,y:pt.y,alpha:1,time:0.5});
			},_count*500);
			
	
			_count++;
			}
		}
	}
}