package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.lobby.classic.model.TableModel;

	public class VirtualTable extends BaseTable
	{	
		public var display:VirtualTableAsset=new VirtualTableAsset();
		public function VirtualTable()
		{
			super();
			this.buttonMode=true;
			this.mouseEnabled=true;
			addChild(display);
		}
		public function setModel(data:TableModel):void{
			display.limitsMC.label.text=data.tableName;
			display.bg.plaqueLimitsMC.min.text=String(data.min);
			display.bg.plaqueLimitsMC.max.text=String(data.max);
			_tableModel=data;
		}
	}
}