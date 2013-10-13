package com.newco.grand.core.common.view.uicomps {
	
	import com.newco.grand.core.common.model.LanguageModel;
	import com.newco.grand.core.common.view.interfaces.IPlayersView;
	import com.newco.grand.core.utils.GameUtils;
	import com.smart.uicore.controls.DataGrid;
	import com.smart.uicore.controls.support.DataGridColumnSet;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * // create an array that has the following fields /map
	 * Array playerarray = new Array("screename", "betamount", "payoff") - key is userid ;
	 * 
	 * map contains:
	 * userid, screename, betamount, payoff
	 * xx123213, joey, 0, 0
	 * populate player list
	 * 
	 * now socket message comes of bet
	 * userid, player, tie, banker amount
	 * 
	 * now you should have a function that
	 * 1. sums the player,tie, banker amount so you get total
	 * then on the playerarray, find the user id, and amend the betamount field
	 * 
	 * 2. do the same for the payout
	 * 
	 * no on start new game, clear array and repeat
	 */
	
	
	
	public class WinnersUIView extends MovieClip implements IPlayersView {
		
		private var _players:XML;
		private var dgCol1Name:String = "Player";
		private var dgCol2Name:String = "Amount";
		private var playersListDgMc:DataGrid;
		public static var count : int=0;
		public function WinnersUIView() {
			visible = false;
			playersListDgMc= new DataGrid();
			playersListDgMc.setSize(190,559);
			addChild(playersListDgMc);
			var sets:Vector.<DataGridColumnSet> = new Vector.<DataGridColumnSet>();
			sets.push(new DataGridColumnSet(dgCol1Name,"first_name",-65));
			sets.push(new DataGridColumnSet(dgCol2Name,"amount",-35));
			playersListDgMc.initColumns(sets);
			
			count++;
			debug("count",count);
		}
		public function updateLanguage():void{
			language();
		}
		public function initDisplay():void{
		}
		public function init():void {			
			align();
		}
		
		public function align():void {
			visible = true;
			y=10;
		}
		
		public function language():void{
			listView.labels[0] = LanguageModel.PLAYERNAME;
			listView.labels[1] = LanguageModel.PLAYERWINS;
		}
		public function resize(width:Number,height:Number):void{
			listView.setSize(width,height);
		}
		public function get players():XML {
			return _players;
		}
		public function updateBetAmounts(userid:String,amount:String):void{
			var data:Object;
			var newData:Object;
			for (var i:uint=0;i<playersListDgMc.length; i++)
			{
				data=playersListDgMc.getItemAt(i);

				if (data.user_id!= null && data.user_id==userid)
				{
					newData={name:data.name,first_name:data.first_name,user_id:data,amount:amount};
					playersListDgMc.replaceItemAt(newData,i);
				}

			}
		
		}
		public function set players(value:XML):void {
			_players = value;
			showPlayers();
		}
		public function loadFormXML(data:XML):void{
			//debug(data);
			playersListDgMc.removeAll();
			var urlsXML:XMLList = data.user;
			var obj:Object;
			for(var i:uint = 0; i < urlsXML.length(); i++) {
				obj={name:urlsXML[i].@name,first_name:urlsXML[i].@first_name,user_id:urlsXML[i].@user_id,amount:"0"};		
				playersListDgMc.addItem(obj);
				
			}
		

		}
		public function get view():Sprite{
			return this;
		}
		public function get listView():DataGrid{
			return playersListDgMc;
		}
		private function showPlayers():void {
			loadFormXML(players)
		}
		
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}