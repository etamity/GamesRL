package com.newco.grand.lobby.classic.view
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	
	import caurina.transitions.Tweener;
	
	import org.osflash.signals.Signal;
	
	public class TablesView extends Sprite
	{
		private var layout:LayoutAsset=new LayoutAsset();
		
		private var baccaratLayer:Sprite=new Sprite();
		
		private var virtualLayer:Sprite=new Sprite();
		private var rouletteLayer:Sprite=new Sprite();
		
		public var PAGE_COUNT:int=4;
		public var PAGE_VTCOUNT:int=6;
		
		public var selectSignal:Signal=new Signal();
		public var openGameSignal:Signal=new Signal();
	
		
		private var _scoreBoradUrl:String;
		
		public function TablesView()
		{
			super();
			addChild(baccaratLayer);
			addChild(rouletteLayer);
			addChild(virtualLayer);
		}
		public function get scoreBoradUrl():String{
			return _scoreBoradUrl;
		}
		public function set scoreBoradUrl(val:String):void{
			 _scoreBoradUrl=val;
		}
		public function clear():void{
			while (baccaratLayer.numChildren>0)
				baccaratLayer.removeChildAt(0);
			while (rouletteLayer.numChildren>0)
				rouletteLayer.removeChildAt(0);
		}
		
		
		public function viewTables():void{
			baccaratLayer.visible=true;
			virtualLayer.visible=false;
		}
		
		public function showVTables(tables:Array,pageNum:int=0):void{
			
			
			baccaratLayer.visible=false;
			virtualLayer.visible=true;
			while (virtualLayer.numChildren>0)
				virtualLayer.removeChildAt(0);
			var count:int=tables.length;
			var begin:int= (pageNum*PAGE_VTCOUNT<count)?pageNum*PAGE_VTCOUNT:pageNum;
			
			var end:int= (begin+PAGE_VTCOUNT<count)?begin+PAGE_VTCOUNT:count;
			var vtablemc:VirtualTable;
			for (var i:int=begin;i<end;i++){
				var pt:Point=new Point(layout.getChildByName("vtable"+String(i%PAGE_COUNT)).x,layout.getChildByName("vtable"+String(i%PAGE_COUNT)).y);
				vtablemc=new VirtualTable();
				vtablemc.setModel(tables[i]);
				virtualLayer.addChild(vtablemc);
				vtablemc.x= pt.x;
				vtablemc.y= pt.y;
				vtablemc.display.bg.stop();
				vtablemc.display.limitsMC.stop();
				vtablemc.addEventListener(MouseEvent.CLICK,doOpenGameEvent);
			}
		}
		
		private function doOpenGameEvent(evt:MouseEvent):void{
			var target:BaseTable=evt.currentTarget as BaseTable;
			openGameSignal.dispatch(target.tableModel);
		}
		
		public function showTables(tables:Array,pageNum:int=0):void{
			var count:int=tables.length;
			var begin:int= (pageNum*PAGE_COUNT<count)?pageNum*PAGE_COUNT:pageNum;

			var end:int= (begin+PAGE_COUNT<count)?begin+PAGE_COUNT:count;
			var btablemc:BaccaratTable;
			var rtablemc:RouletteTable;
			
			trace("count:",count,begin,end)
			
			for (var i:int =begin; i<end;i++)
			{
		
					if (tables[i].game=="baccarat")
					{   		
						var pt:Point=new Point(layout.getChildByName("baccarattable"+String(i%PAGE_COUNT)).x,layout.getChildByName("baccarattable"+String(i%PAGE_COUNT)).y);
						btablemc=new BaccaratTable();
						btablemc.setModel(tables[i]);
						baccaratLayer.addChild(btablemc);
						//btablemc.alpha=0;

						btablemc.x= pt.x;
						btablemc.y= pt.y;
						btablemc.display.screenshot.gotoAndStop(i%PAGE_COUNT);
						var url:String=_scoreBoradUrl+"?table_id=#TABLE_ID#";
						btablemc.loadScore(url);
						/*setTimeout(function ():void{
						Tweener.addTween(btablemc,{x:pt.x,y:pt.y,alpha:1,time:0.5});
						},i*500);*/
						btablemc.addEventListener(MouseEvent.CLICK,doSelectTable);
					}
					if (tables[i].game=="roulette")
					{   		
						var pt1:Point=new Point(layout.getChildByName("roulettetable"+String(i%PAGE_COUNT)).x,layout.getChildByName("roulettetable"+String(i%PAGE_COUNT)).y);
						rtablemc=new RouletteTable();
						rtablemc.setModel(tables[i]);
						rouletteLayer.addChild(rtablemc);
						//rtablemc.alpha=0;
						rtablemc.x= pt1.x;
						rtablemc.y= pt1.y;
						rtablemc.addEventListener(MouseEvent.CLICK,doSelectTable);
						/*setTimeout(function ():void{
							Tweener.addTween(rtablemc,{x:pt1.x,y:pt1.y,alpha:1,time:0.5});
						},i*500);*/
					}
					
				}
			
		}
		
		private function doSelectTable(evt:MouseEvent):void{
			var target:BaseTable=evt.currentTarget as BaseTable;
			selectSignal.dispatch(target.tableModel);
		}
	}
}