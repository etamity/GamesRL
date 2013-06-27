package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	import com.newco.grand.lobby.classic.model.TableModel;
	
	import flash.display.Sprite;
	
	public class TableView extends Sprite implements IUIView
	{
		protected var _display:*;
		
		public function TableView()
		{
		}
		
		public function init():void
		{
		}
		
		public function align():void
		{
		}
		
		public function get display():*
		{
			return this;
		}
		
		public function initDisplay():void
		{
			_display= new TableAsset();
			addChild(_display);
		}
		
		public function setModel(data:TableModel):void{
			_display.tableName.text=data.tableName;
			_display.min.text=data.min;
			_display.max.text=data.max;
		}
	}
}