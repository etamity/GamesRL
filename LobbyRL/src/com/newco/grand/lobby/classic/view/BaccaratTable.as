package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.core.common.view.scorecard.ScoreCard;
	import com.newco.grand.lobby.classic.model.TableModel;

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
			scoreBoard.x=235;
			scoreBoard.y=7;
		}
		public function setModel(data:TableModel):void{
			display.tableName.text=data.tableName.toUpperCase();
			display.min.text=String(data.min);
			display.max.text=String(data.max);
			_tableModel=data;
		}
		public function loadScore(url:String):void{
			scoreBoard.init(220,140,false,false,_tableModel.tableid,0xFFFFFF,url);
		}
	}
}