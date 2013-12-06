#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @attachListeners()

  attachListeners: ->  
    @get('playerHand').on 'all', @playerEvents, @
    @get('dealerHand').on 'all', @dealerEvents, @

  playerEvents: (event) ->
    haveDealerHit =  =>
      unless @get('dealerHand').scores()[0] >= 17
         @get('dealerHand').hit()
     # @checkScores()

    playerHasBlackJack = =>
      console.log "app: player has black jack!"
      @endGame false, "blackjack"

    playerHasBust = =>
      console.log "app: player has bust"
      @endGame false, "bust"

    playerHasTwentyOne = =>
      console.log "app: player has twenty one"
      @endGame false, "twentyone"

    switch event
      when 'playerHit' then haveDealerHit() 
      when 'blackjack' then playerHasBlackJack() 
      when 'bust' then playerHasBust() 
      when 'twentyOne' then playerHasTwentyOne() 
      when 'playerStand' then haveDealerHit() 

  dealerEvents: (event) ->
    dealerHasBlackJack = =>
      console.log "app: dealer has black jack!"
      @endGame true, "blackjack"

    dealerHasBust = =>
      console.log "app: dealer has bust"
      @endGame true, "bust"

    dealerHasTwentyOne = =>
      console.log "app: dealer has twenty one"
      @endGame true, "twentyone"

    switch event
      when 'blackjack' then dealerHasBlackJack() 
      when 'bust' then dealerHasBust() 
      when 'twentyOne' then dealerHasTwentyOne() 

  checkScores: ->
    playerScore = @get('playerHand').scores()[0]
    dealerScore = @get('dealerHand').scores()[0]
    if playerScore > dealerScore
      @endGame false, "won"
    else
      @endGame true, "won"
    console.log "player: #{@get('playerHand').scores()}, dealer: #{@get('dealerHand').scores()}"

  endGame: (isDealer, state) ->
    hand = if isDealer then "Dealer" else "Player"
    console.log "#{hand} has #{state}"
    console.log "GAME OVER"

    alert "#{hand} has #{state}\nGAME OVER!"

    # how to i create a new game?
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @attachListeners()
    console.log "app: about to trigger newGame"
    @trigger 'newGame'

