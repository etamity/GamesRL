package com.newco.grand.roulette.classic.view
{	
	import com.newco.grand.core.common.view.Betchip;
	import com.smart.uicore.controls.DataGrid;
	import com.smart.uicore.controls.support.DataGridColumnSet;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import org.osflash.signals.Signal;

	public class PlayersBetsView extends PlayersBetsAsset
	{
		private var _players:XML;
		private var dgCol1Name:String = "Player";
		private var dgCol2Name:String = "Amount";
		private var playersListDgMc:DataGrid;
		private var selectedPlayerIndex:int=-1;
		public var dataChangeSignal:Signal=new Signal();
		public function PlayersBetsView()
		{
			//numbersMc.addEventListener(MouseEvent.CLICK,createDataGrid);
			createDataGrid(null);
			//numbersMc.betsMc.alpha=0;
			playersListDgMc.addEventListener(Event.CHANGE,doSelectBets);
		}
		private function doSelectBets(evt:Event):void{
			selectedPlayerIndex = evt.target.selectedIndex;
			if (selectedPlayerIndex>=0)
			{
				//dispatchEvent(new DataGirdEvent(DataGirdEvent.CHANGE,playersListDgMc.selectedItem));
				dataChangeSignal.dispatch(playersListDgMc.selectedItem);
			}
		}
		public function get colum1():String{
			return dgCol1Name;
		}
		public function get colum2():String{
			return dgCol2Name;
		}
		
		public function loadBetsString(val:String):void{
		   var betsArray:Array = val.split("&");
		   var value:Array;
		   var bets:int;
		   var amount:Number;
		   var chip:Betchip;
		   var betSpotMc:MovieClip;

		   while (numbersMc.chipsBoard.numChildren>0)
			   numbersMc.chipsBoard.removeChildAt(0);
		   for (var i:int=1;i<betsArray.length ;i++)
		   {
			   var test:String=betsArray[i];
			   ;
			   value= String(betsArray[i]).split("=");
			   bets=int(value[0]);
			   betSpotMc= MovieClip(numbersMc.getChildByName("dz"+String(bets)));
			   amount=int(value[1]);
			   chip=new Betchip();
			   chip.value.text =String(amount);
			   chip.scaleX=chip.scaleY=0.9;
			   chip.x = betSpotMc.x -( chip.width /2);
			   chip.y = betSpotMc.y- ( chip.height /2);
			   chip.updateChipColor(amount);
			   numbersMc.chipsBoard.addChild(chip);
			   
			   
		   }
		   
		}
		
		private function createDataGrid(evt:MouseEvent):void{
		
			playersListDgMc= new DataGrid();
			playersListDgMc.setSize(164,136);
			//playersListDgMc.x=2.65;
			//playersListDgMc.y=270.75;
			
			addChild(playersListDgMc);
			
			var sets:Vector.<DataGridColumnSet> = new Vector.<DataGridColumnSet>();
			sets.push(new DataGridColumnSet(dgCol1Name,"first_name",-65));
			sets.push(new DataGridColumnSet(dgCol2Name,"amount",-35));
			playersListDgMc.initColumns(sets);
			
			
	
		}
		
		public function get dataGrid():DataGrid{
			return playersListDgMc;
		}
		
		public function init():void {			
			align();
		}
		
		public function align():void {
			visible = true;
		}

		public function get players():XML {
			return _players;
		}
		
		public function set players(value:XML):void {
			_players = value;
			//showPlayers();
		}
	}
}