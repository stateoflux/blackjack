#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'playerHit', @haveDealerHit, @
    @get('playerHand').on 'playerStand', @haveDealerHit, @
    @get('playerHand').on 'bust', @endGame, @ 
    @get('dealerHand').on 'bust', @endGame, @

  haveDealerHit: ->
    @get('dealerHand').hit()

  endGame: ->
    console.log "GAME OVER!!"
    # result = prompt "game over. do you want to play again?"
    console.log "result: "
    # if result.lowercase() === "yes"
    #   @set 'deck', deck = new Deck()
    #   @set 'playerHand', deck.dealPlayer()
    #   @set 'dealerHand', deck.dealDealer()
    #   @render() 








