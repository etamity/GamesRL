package com.newco.grand.lobby.mobile.view
{
	import com.newco.grand.core.common.model.Constants;
	import com.newco.grand.lobby.classic.model.TableModel;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.Signal;
	
	public class LobbyView extends LobbyAsset
	{
		
		public var baccaratTables:MovieClip=new MovieClip();
		public var rouletteTables:MovieClip=new MovieClip();
		public var blackjackTables:MovieClip=new MovieClip();
		
		public var opengameSginal:Signal=new Signal();
		public function LobbyView()
		{
			super();
			addChild(baccaratTables);
			addChild(rouletteTables);
			addChild(blackjackTables);
		}
		
		public function loadTables(tables:Array):void{
			var table:TableModel;

			baccaratTables.removeChildren();
			rouletteTables.removeChildren();
			blackjackTables.removeChildren();
			for (var i:int=0;i<tables.length;i++)
			{
				table=tables[i];
				if (table.game==Constants.BACCARAT.toLowerCase())
				{
					var mc:BaccaratItem=new BaccaratItem();
					mc.tableName.text=table.tableName;
					mc.max.text=String(table.max);
					mc.min.text=String(table.min);
					mc.y=stage.stageHeight-mc.height*(i+1);
					mc.table=table;
					mc.addEventListener(MouseEvent.CLICK,openGame);
					baccaratTables.addChild(mc);
				}
				if (table.game==Constants.ROULETTE.toLowerCase())
				{
					var mc1:RouletteItem=new RouletteItem();
					mc1.tableName.text=table.tableName;
					mc1.max.text=String(table.max);
					mc1.min.text=String(table.min);
					mc1.y=stage.stageHeight-mc1.height*(i+1);
					mc1.table=table;
					mc1.addEventListener(MouseEvent.CLICK,openGame);
					rouletteTables.addChild(mc1);
				}

			}
		}
		
		private function openGame(evt:MouseEvent):void{
			var target:Object=evt.currentTarget;
			opengameSginal.dispatch(target.table);
		}
	}
}
import com.newco.grand.lobby.classic.model.TableModel;

class BaccaratItem extends BaccaratItemAsset{
	public var table:TableModel;
	public function BaccaratItem(){
		tableName.mouseEnabled=false;
		max.mouseEnabled=false;
		min.mouseEnabled=false;
		minLabel.mouseEnabled=false;
		maxLabel.mouseEnabled=false;
	}
}
class RouletteItem extends RouletteItemAsset{
	public var table:TableModel;
	public function RouletteItem(){
		tableName.mouseEnabled=false;
		max.mouseEnabled=false;
		min.mouseEnabled=false;
		minLabel.mouseEnabled=false;
		maxLabel.mouseEnabled=false;
	}
}