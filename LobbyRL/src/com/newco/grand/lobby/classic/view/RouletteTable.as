package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.lobby.classic.model.TableModel;

	public class RouletteTable extends BaseTable
	{	
		public var display:RouletteTableAsset=new RouletteTableAsset();
		public function RouletteTable()
		{
			super();
			this.buttonMode=true;
			this.mouseEnabled=true;
			addChild(display);
		}
		public function setModel(data:TableModel):void{
			display.label.text=data.tableName.toUpperCase();
			//min.text=String(data.min);
			//max.text=String(data.max);
			_tableModel=data;
		}
	}
}