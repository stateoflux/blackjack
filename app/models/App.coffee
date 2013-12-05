#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'playerHit', @haveDealerHit, @
    @get('playerHand').on('bust', ->
      console.log "app: heard bust event"  
      # player has busted need to display the appropriate message 

      # start a new game
    , @)

  haveDealerHit: ->
    @get('dealerHand').hit()

