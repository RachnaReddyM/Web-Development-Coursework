defmodule Memory.Game do


# To generate cards with letters
def makeCards do
  makeCard =[]
  cardLetters = ~w(A B C D E F G H A B C D E F G H)
  cardList = Enum.shuffle(cardLetters)
  id = 0
  showCards(cardList,makeCard,id)
end

# Generate 16 cards with attributes
def showCards(cardList,makeCard,count) do
    if((length cardList)!=0) do
      card = %{id: count,
               value: hd(cardList),
               matched: false,
               flipped: false}
      makeCard = makeCard ++ [card]
      cardList = tl(cardList)
      showCards(cardList,makeCard,(count + 1))
    else
      makeCard
    end
end

# new game initialization
def newGame do
%{
    cards: makeCards(),
    openCard: false,
    openCardId: 0,
    openCardValue: '',
    noOfMatches: 0,
    noOfClicks: 0,
    freeze: false,
    delayVar: false,
    score: 0,
}
end


def client_view(game) do
%{
    cards: game[:cards],
    openCard: game.openCard,
    openCardId: game.openCardId,
    openCardValue: game.openCardValue,
    noOfMatches: game.noOfMatches,
    noOfClicks: game.noOfClicks,
    freeze: game.freeze,
    delayVar: game.delayVar,
    score: game.score,
}
end

# to reset game
def gameReset(game,idset) do

    newGame()

end


def cardFlipped(game,id,val) do
  cards = game[:cards]
  presentCard = Enum.at(cards,id)

      # If delay is not required
      if(!(game.delayVar)) do

           # If clicked card is not a yet flipped
           if(!(presentCard.flipped)) do

                     clicks = (game.noOfClicks) + 1
                     game = %{game | noOfClicks: clicks}
                     scores = 500-((game.noOfClicks) * 2)
                     game = %{game | score: scores}
                     cards = game[:cards]
                     newCard = []
                     newCard = Enum.map(cards, fn(c) ->
                                if ((c.id == id) and (!c.flipped)) do
                                    newCard = newCard ++ %{id: c.id,
                                                           value: c.value,
                                                           matched: c.matched,
                                                           flipped: true}
                                else
                                    newCard = newCard ++ c
                                end
                                end)
                      game = Map.put(game, :cards, newCard)

                      # if one card is open
                      if (game.openCard) do

                         game = %{game | freeze: true}

                         # if the two open cards match
                         if (game.openCardValue == val) do
                                match = (game.noOfMatches) + 1
                                game = %{game | noOfMatches: match}
                                cards = game[:cards]
                                newCard = []
                                newCard = Enum.map(cards, fn(c) ->
                                              if ( (c.id == id) or
                                                  (c.id == game.openCardId)) do
                                                newCard = newCard ++ %{id: c.id,
                                                                 value: c.value,
                                                                  matched: true,
                                                            flipped: c.flipped}

                                              else
                                                  newCard = newCard ++ c
                                              end
                                           end)

                          game = Map.put(game, :cards, newCard)
                          game = %{game | openCard: false}
                          game = %{game | openCardId: id}
                          game = %{game | openCardValue: val}
                          game = %{game | freeze: false}
                          game = %{game | delayVar: false}


                    else
                          # apply delay and un-flip the open cards
                          game = %{game | delayVar: true}



                    end

                  else
                       game = %{game | openCard: true}
                       game = %{game | openCardId: id}
                       game = %{game | openCardValue: val}
                       game = %{game | freeze: false}
                       #game = %{game | delayVar: false}
                       game = Map.put(game, :cards, newCard)

                  end


        else
           game = Map.put(game, :cards, cards)
        end
     else

     # apply delay and set card
     newCard = []
     newCard = Enum.map(cards, fn(c) ->
                    if (c.flipped and (!c.matched)) do
                                    newCard = newCard ++ %{id: c.id,
                                                     value: c.value,
                                                     matched: c.matched,
                                                     flipped: false}
                    else
                        newCard = newCard ++ c
                    end
                    end)
                    game = %{game | openCard: false}
                    game = %{game | openCardId: 0}
                    game = %{game | openCardValue: ''}
                    game = %{game | freeze: false}
                    game = %{game | delayVar: false}
                    game = Map.put(game, :cards, newCard)

     end

end
end
