package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.core.common.components.scorecard.ScoreCard;
	import com.newco.grand.lobby.classic.model.TableModel;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class BaccaratTable extends BaseTable
	{	
		public var display:BaccaratTableAsset=new BaccaratTableAsset();
		
		private var scoreBoard:ScoreCard;
		
		
		
		public function BaccaratTable()
		{
			super();
			this.buttonMode=true;
			this.mouseEnabled=true;
			scoreBoard=new ScoreCard();
		
			addChild(display);
			addChild(scoreBoard);
			scoreBoard.x=2;
			scoreBoard.y=130;
		}
		
		public function loadAvatar(url:String):void{
			var loader:Loader=new Loader();
			display.avatar.addChild(loader);

			
			loader.addEventListener(Event.COMPLETE,function (evt:Event):void{
				loader.width=95;
				loader.height=85;
			});
			
			var request:URLRequest = new URLRequest(url);
			try{
			loader.load(request);
			}
			catch (err:Error)
			{
				trace(err);
			}
		}
		
		public function setModel(data:TableModel):void{
			display.tableName.text=data.tableName.toUpperCase();
			display.min.text=String(data.min);
			display.max.text=String(data.max);
			_tableModel=data;
		}
		public function loadScore(url:String):void{
			scoreBoard.init(250,159,false,false,_tableModel.tableid,0xFFFFFF,url);
		}
	}
}