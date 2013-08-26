package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.lobby.classic.model.TableModel;
	
	import flash.display.Sprite;
	
	public class BaseTable extends Sprite
	{
		protected var _tableModel:TableModel;
		public function BaseTable()
		{
			super();
		}
		public function get tableModel():TableModel{
			return _tableModel;
		}
	}
}