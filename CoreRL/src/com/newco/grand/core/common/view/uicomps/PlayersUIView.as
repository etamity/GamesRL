package com.newco.grand.core.common.view.uicomps
{
	import com.newco.grand.core.common.view.interfaces.IPlayersView;
	import com.smart.uicore.controls.List;
	import com.smart.uicore.controls.proxy.CustomListItem;
	
	import flash.display.MovieClip;
	
	public class PlayersUIView extends MovieClip implements IPlayersView
	{
		private var _players:XML;
		private var listView:List;
		public function PlayersUIView()
		{
			super();
			listView=new List();
			listView.y=5;
			listView.setSize(167,529);
			addChild(listView);
		}
		public function align():void {
			visible = true;
		}
		public function init():void {			
			align();
		}
		public function get players():XML {
			return _players;
		}
		public function resize(width:Number,height:Number):void{
			listView.setSize(width,height);
		}
		public function set players(value:XML):void {
			_players = value;
			showPlayers();
		}
		
		private function showPlayers():void {
			listView.removeAll();
			var obj:CustomListItem;
			for each (var item:XML in players.user) {
				if (item != "onlinecasinolar o" )
				{
					obj=new CustomListItem();
					obj.label=item;
					listView.addItem(obj);
				}
			}
		}
	}
}