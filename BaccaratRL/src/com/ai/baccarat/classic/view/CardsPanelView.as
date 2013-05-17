package com.ai.baccarat.classic.view
{	
	import com.ai.baccarat.classic.model.BaccaratConstants;
	import com.ai.core.utils.GameUtils;
	import com.ai.core.utils.StringUtils;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import caurina.transitions.Tweener;
	
	public class CardsPanelView extends CardsPanelAsset
	{
		public var cardsData:Array=new Array(
			"c101","c102","c103","c104","c105","c106","c107","c108","c109","c110","c111","c112","c113",
			"c201","c202","c203","c204","c205","c206","c207","c208","c209","c210","c211","c212","c213",
			"c301","c302","c303","c304","c305","c306","c307","c308","c309","c310","c311","c312","c313",
			"c401","c402","c403","c404","c405","c406","c407","c408","c409","c410","c411","c412","c413");
		
		
		
		public var cardsServerData:Array =new Array("");
		
		private var slideTime:Number= 1;

		private var bankerCardPt:Point= new Point(275,340);
		private var playerCardPt:Point= new Point(725,340);
		
		private var bankerCards:Array;
		private var playerCards:Array;
		
		private var cardsMc:MovieClip;


		
		public function CardsPanelView()
		{
			bankerCards=new Array();
			playerCards=new Array();
			bankerCardPt= new Point(BankerSide.x+50,BankerSide.y-80);
			playerCardPt= new Point(playerSide.x+50,playerSide.y-80);
			cardsMc=new MovieClip();
			addChild(cardsMc);
			refreshScore();
			visible=false;

		}
		public function refreshScore():void{
			BankerSide.label.text = String(totalScore(BaccaratConstants.BANKER));
			playerSide.label.text = String(totalScore(BaccaratConstants.PLAYER));
		}

		public function totalScore(side:String):int{
			var cards:Array=(side==BaccaratConstants.BANKER)?bankerCards:playerCards;
			var score:int=0;
			var card:Card;
			var length:int=cards.length;
			for (var i:int=0; i<length;i++)
			{
				card=cards[i];
				score += card.value;
			}
			score=(score>=10)? score-10:score;
			return score;
		}
		
		public function issueCard(side:String,value:String):void{
			var card:Card=new Card(value,side);
			cardsMc.addChild(card);
			addCard(card);
			card.alpha=0;
			switch (side)
			{
				case BaccaratConstants.BANKER:
					 moveBanker(card);
					break;
				case BaccaratConstants.PLAYER:
					 movePlayer(card);
					break;
			}

			
		}
		
		public function moveBanker(card:Card):void{
			moveCardto(card,new Point(0,0),bankerCardPt,onFinishedCardMoved);
	
		
		}
		
		public function movePlayer(card:Card):void{
			moveCardto(card,new Point(0,0),playerCardPt,onFinishedCardMoved);
	
		}
		
		private function addCard(card:Card):void{
			switch (card.side)
			{
				case BaccaratConstants.BANKER:
					bankerCards.push(card);
					break;
				case BaccaratConstants.PLAYER:
					playerCards.push(card);
					break;
			}
		}
		private function onFinishedCardMoved(card:Card):void{
			adjustCardPosition(card.side);
			card.showCard();
			refreshScore();
			
		}
		
		public function cleanPanel():void{
			cardsMc.removeChildren();
			bankerCards=new Array();
			playerCards=new Array();
			refreshScore();
		}
		
		public function showAllCards():void{
			var card:Card;
			for (var a:int=0; a<bankerCards.length;a++)
			{
				card=bankerCards[a];
				card.showCard();
			}
			for (var b:int=0; b<bankerCards.length;b++)
			{
				card=playerCards[b];
				card.showCard();
			}
		}
		
		private function adjustCardPosition(side:String):void{
			var newPt:Point;
			var cards:Array=(side==BaccaratConstants.BANKER)?bankerCards:playerCards;
			var card:Card;
			var length:int=cards.length;
			var cardOffsetX:int;
			for (var i:int=0; i<length;i++)
			{
				card=cards[i];
				cardOffsetX=card.width/2;
				var OffsetX:int = (length *card.width/2)/2 ;
				switch (side)
				{
					case BaccaratConstants.BANKER:
						newPt=bankerCardPt.clone();
						break;
					case BaccaratConstants.PLAYER:
						newPt=playerCardPt.clone();
						
						break;
				}
				
				newPt.x -=cardOffsetX*(length-i)-OffsetX;
				moveCardto(card,new Point(card.x,card.y),newPt);
			}
		}

		private function moveCardto(card:Card, start:Point, end:Point, complete:Function=null):void{
			card.x=start.x;
			card.y=start.y;
			Tweener.addTween(card,{alpha:1,x:end.x,y:end.y, time: 1, onComplete:complete,onCompleteParams:[card]});
		}
		private function debug(...args):void {
			GameUtils.log(this, args);
		}
	}
}