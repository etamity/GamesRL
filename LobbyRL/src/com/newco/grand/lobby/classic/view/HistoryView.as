package com.newco.grand.lobby.classic.view
{
	import com.smart.uicore.controls.DataGrid;
	import com.smart.uicore.controls.TabBar;
	import com.smart.uicore.controls.Window;
	
	public class HistoryView extends Window
	{
		private var accountHistory:DataGrid;
		private var activityHisory:DataGrid;
		
		private var tabbar:TabBar;
		public function HistoryView()
		{
			super();
			tabbar=new TabBar();
			setSize(500,400);
			tabbar.setSize(500,360);
			tabbar.y=30;
			addChild(tabbar);

			
			accountHistory=new DataGrid();
			activityHisory=new DataGrid();
			visible=false;
			accountHistory.columnWidths=[150,80,150];
			accountHistory.setSize(460,300);
			accountHistory.labels=["Date","Stake","Win/Lose"];
			accountHistory.dataField=["date","stake","winlose"];

			activityHisory.setSize(460,300);
			activityHisory.columnWidths=[150,80,80,100];
			activityHisory.labels=["Time","Currency Code","Amount","Win/Lose"];
			activityHisory.dataField=["time","currency","amount","winlose"];
		}
		
		public function init():void{
			x= (stage.width -width) /2;
			y =60;
			ableUserResizeWindow=false;
			tabbar.addTab("MY HISTORY",accountHistory);
			tabbar.addTab("MY ACTIVITY",activityHisory);
		}
		public function setAccountData(data:XML):void{
			var items:XMLList=data.item;
			var item:Object;
			for (var i:int=0;i<items.length();i++)
			{
				item={date:items[i].@date,stake:items[i].@stake,winlose:items[i].@winlose};
				accountHistory.addItem(item);
			}
			visible=true;
			
		}
		
		public function setActivityData(data:XML):void{
			visible=true;
			var items:XMLList=data.bet;
			var item:Object;
			for (var i:int=0;i<items.length();i++)
			{
				item={time:items[i].bet_time,currency:items[i].bet_currency_code,amount:items[i].bet_amount,winlose:items[i].bet_winlose};
				activityHisory.addItem(item);
			}
			visible=true;
		}
	}
}