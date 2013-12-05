#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

    # @get('playerHand').on 'playerHit', @haveDealerHit, @ 
    @listenTo(@get('playerHand'), 'playerHit', @haveDealerHit)
    @listenTo(@get('playerHand'), 'playerStand', @haveDealerHit)
    @listenTo(@get('playerHand'), 'blackjack', @playerHasBlackJack)
    @listenTo(@get('playerHand'), 'bust', @playerHasBust)
    @listenTo(@get('playerHand'), 'twentyOne', @playerHasTwentyOne)
    # @get('playerHand').on 'playerHit', @checkScores, @
    # @get('playerHand').on 'playerStand', @haveDealerHit, @,
    # @get('playerHand').on 'blackjack', @playerHasBlackJack, @
    # @get('playerHand').on 'bust', @playerHasBust, @
    # @get('playerHand').on 'twentyOne', @playerHasTwentyOne, @

    
    @listenTo(@get('dealerHand'), 'blackjack', @dealerHasBlackJack)
    @listenTo(@get('dealerHand'), 'bust', @dealerHasBust)
    @listenTo(@get('dealerHand'), 'twentyOne', @dealerHasTwentyOne)
    # @get('dealerHand').on 'blackjack', @dealerHasBlackJack, @
    # @get('dealerHand').on 'bust', @dealerHasBust, @
    # @get('dealerHand').on 'twentyOne', @dealerHasTwentyOne, @

  haveDealerHit: ->
    @get('dealerHand').hit() unless @get('dealerHand').scores[0] >= 17

  playerHasBlackJack: ->
    console.log "app: player has black jack!"
    @endGame false, "blackjack"

  playerHasBust: ->
    console.log "app: player has bust"
    @endGame false, "bust"

  playerHasTwentyOne: ->
    console.log "app: player has twenty one"
    @endGame false, "twentyone"

  dealerHasBlackJack: ->
    console.log "app: dealer has black jack!"
    @endGame true, "blackjack"

  dealerHasBust: ->
    console.log "app: dealer has bust"
    @endGame true, "bust"

  dealerHasTwentyOne: ->
    console.log "app: dealer has twenty one"
    @endGame true, "twentyone"

  checkScores: ->
    # if dealer is standing @ 17 and player has higher score
      # player wins
    # if dealer score and player scores are above 17 and the equal
      # game is a push

    console.log "player: #{@get('playerHand').scores()}, dealer: #{@get('dealerHand').scores()}"

  endGame: (isDealer, state) ->
    # if player has bust
      # player loses
      # call endGame passing in a flag to represent player or dealer  
      # how do i do this?
    # else if dealer has bust
      # dealer loses
    # if player has bust
    # else if dealer has twenty one
      # dealer wins
    # else if player has twenty one
      # player wins
    hand = if isDealer then "Dealer" else "Player"
    console.log "#{hand} has #{state}"
    console.log "GAME OVER"

    alert "#{hand} has #{state}\nGAME OVER!"

    # how to i create a new game?
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    console.log "app: about to trigger newGame"
    @trigger 'newGame'



