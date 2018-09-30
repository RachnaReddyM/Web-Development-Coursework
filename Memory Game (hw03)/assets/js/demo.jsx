import React from 'react';
import ReactDOM from 'react-dom';
import classnames from 'classnames';
import shuffle from 'shuffle-array';


export default function run_demo(root) {
  ReactDOM.render(<Demo />, root);
}


//List of characters in the game
const cardLetters= ['A','A','B','B','C','C','D','D','E','E','F','F','G','G','H','H'];


// Function to create a card object and shuffle them
function makecardShow()
{
  let makeCards=[];

  for(let i=0;i<16;i++)
  {
    let pair={
      id:i,
      key:cardLetters[i],
      matched: false,
      flipped:false
    };

    makeCards.push(pair);


  }

  //Attribution: Javascript utility used to shuffle elements in an array from New Programs Makers
  shuffle(makeCards);
  return makeCards;

}


class Demo extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
     cards:makecardShow(), // a set of cards
     openCard:false,       // sets to true when a card is displayed
     openCardId:0,         // Card ID of the flipped card
     openCardValue:'',     // Card letter of the flipped card
     noOfMatches:0,        // No. of cards matched
     noOfClicks:0,         // No. of cards flipped open
     freeze:false,         // is set to true when 2 cards are displayed 
                           // and should ignore any clicks for 1 sec
     score:0               // to maintain the player's score
   };

   this.showAllCards = this.showAllCards.bind(this);
   this.cardsReset = this.cardsReset.bind(this);

 }


 // Function to create the cards

 showAllCards(cards)
{

  return cards.map((card,index) => {
    return ( <Card
      key={index}
      id={index}
      item={card}
      value={card.key}
      flipped={card.flipped}
      matched={card.matched}
      cardFlip={this.cardFlip.bind(this)} />);

  });

}


 // Funtion called when a card is clicked on
 cardFlip(cardId,cardValue){

   var allCards = this.state.cards;


   if(!allCards[cardId].flipped) // when a card is unflipped
   {
    if(!this.state.freeze) // when only one card or no card is dispalyed
    {
      var clicks = parseInt(this.state.noOfClicks)+1;
      var scores = 500-(parseInt(this.state.noOfClicks)*2);
      allCards[cardId].flipped = true;
      this.setState({cards : allCards, noOfClicks:clicks,freeze:true, score:scores});
      if(this.state.openCard)   // when a single card is opened
      {
        if(this.state.openCardValue == cardValue) // when both the flipped cards match
        {
  
         var matches= parseInt(this.state.noOfMatches)+1;
         console.log(matches);
         allCards[this.state.openCardId].matched = true;
         allCards[cardId].matched = true;

         this.setState({
           cards:allCards,
           openCard: false,
           openCardId:0,
           openCardValue:'',
           noOfMatches:matches,
           freeze:false
         });

       }
       else // when cards do not match
       {
        // cards close in 1 second delay.
        setTimeout(() => {
          allCards[this.state.openCardId].flipped = false;
          allCards[cardId].flipped = false;
          this.setState({cards: allCards,
           openCard:false,
           openCardId:0,
           openCardValue:'',
           freeze:false
         })},1000);

      }
    }

    else // when only one card is clicked open
    {
      this.setState
      ({
        cards:allCards,
        openCard: true,
        openCardId: cardId,
        openCardValue: cardValue,
        freeze:false
      });

    }

  }

  }

}



// Function to reset the game

cardsReset()
{
  console.log(this.state.noOfMatches);
  console.log("enterted restart fucntion");
  this.setState ({ cards:makecardShow(),
    openCard:false,
    openCardId:0,
    openCardValue:'',
    noOfMatches:0,
    noOfClicks:0,
    freeze:false,
    score:0
  });

}

render() {
  var buttonText = "Restart";
  var matches = parseInt(this.state.noOfMatches);

  if ( matches == 8)
  {
    var finalscore =(this.state.score);
    setTimeout(() => {
    alert("You Won!!!"+"\n"+"Your score is: "+finalscore)},1000);
    setTimeout(() => {this.cardsReset()},3000);
  }
 let cardShow= this.showAllCards(this.state.cards);
  return (
    <div>
    <div className="container">
    <p className="clicks">Flipped cards until now:{this.state.noOfClicks}</p>
    <p className="scores">Score:{this.state.score}</p>
    <div className="row">
    {cardShow}
    </div>
    <button onClick={this.cardsReset}>{buttonText}</button>
    </div>
    <div className="footer">
    </div>
    </div>
    );
}


}


function Card(props) {
 let item= props.item;


 //Attribution: Javascript utility used to set multiple classnames based on condition from New Programs Makers
 var className = classnames(
               'card':true,
              {'flipped': props.flipped},
              {'matched': props.matched}
              );
 var cardValue =' ';
 if (props.flipped)
 {
    cardValue= props.value;
 }

 return (
  <div className ="col-sm-3">
  <div className ={className} onClick={() =>props.cardFlip(props.id,props.value)}>
  <p className="letters">{cardValue}</p>
  </div>
  </div>

  );
}