package com.newco.grand.lobby.classic.view
{
	import com.newco.grand.core.common.view.interfaces.IUIView;
	import com.newco.grand.lobby.classic.model.TableModel;
	
	import flash.display.Sprite;
	import flash.media.Video;
	
	public class TableView extends Sprite implements IUIView
	{
		protected var _display:TableAsset;
		private var _video:Video;
		public function TableView()
		{
			
			_video=new Video();
			addChild(_video);
			initDisplay();
			_video.width=_display.width;
			_video.height=_display.height;
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
			_display.min.text=String(data.min);
			_display.max.text=String(data.max);
		}
	}
}