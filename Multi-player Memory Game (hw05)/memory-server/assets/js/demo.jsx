import React from 'react';
import ReactDOM from 'react-dom';
import classnames from 'classnames';
import shuffle from 'shuffle-array';


export default function game_init(root, channel) {
  ReactDOM.render(<MainClass channel={channel}/>, root);
}



class MainClass extends React.Component{
      constructor(props) {
                  super(props);
                  this.channel = props.channel;
                  this.state = {
                    cards:[],           // a set of cards
                    openCard:false,     // sets to true when a card is displayed
                    openCardId:0,       // Card ID of the flipped card
                    openCardValue:'',   // Card letter of the flipped card
                    noOfMatches:0,      // No. of cards matched
                    noOfClicks:0,       // No. of cards flipped open
                    freeze:false,       // is set to true when 2 cards are
                                        // displayed and should ignore any
                                        // clicks for 1 sec
                    score:0,            // to maintain the player's score
                    delayVar:false
                    };

                  this.channel.join()
                  .receive("ok", this.setView.bind(this))
                  .receive("error", resp =>
                          { console.log("Join failed", resp)});
                          }

  setView(view)
  {
    let current_view = this;
    console.log("New view", view.game);
    this.setState(view.game);

    // to set 1 second delay
    if (view.game.delayVar)
    {
      console.log("Entered Here")
      setTimeout(function(){
      current_view.channel.push("cardFlipped",
      {id: view.game.openCardId, body: view.game.openCardValue})
      .receive("ok",current_view.setView.bind(current_view))},1000);
    }
  }


  // Card components
  showAllCards(cards)
  {
   return cards.map((card,index) => {
     return ( <Card
       id={card.id}
       key={card.id}
       value={card.value}
       flipped={card.flipped}
       matched={card.matched}
       cardFlip={this.cardFlip.bind(this)} />);

   });

  }


  // Function called when a card is clicked on
  cardFlip(cardId,cardValue)
  {
    if(!(this.state.freeze))
    {
    this.channel.push("cardFlipped",{id: cardId, body: cardValue})
    .receive("ok", this.setView.bind(this));
    }

  }

  // Function called to reset cards on Restart click or game finish
  cardsReset()
  {
     console.log("restart clicked")
     this.channel.push("gameReset",{id: "reset"})
    .receive("ok", this.setView.bind(this));

  }



render() {

  var buttonText = "Restart";
  var matches = parseInt(this.state.noOfMatches);

  // when all cards are matched
  if ( matches == 8)
  {
    var finalscore =(this.state.score);
    setTimeout(() => {
    alert("You Won!!!"+"\n"+"Your score is: "+finalscore)},1000);
    setTimeout(() => {this.cardsReset()},2500);
  }

  // Generate cards
 let cardShow= this.showAllCards(this.state.cards);
  return (
    <div>
    <div className="container">
    <p className="clicks">Flipped cards until now:{this.state.noOfClicks}</p>
    <p className="scores">Score:{this.state.score}</p>
    <div className="row">
    {cardShow}
    </div>
    <button onClick={this.cardsReset.bind(this)}>{buttonText}</button>
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
 console.log(props.value);
 console.log(props.flipped);
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
