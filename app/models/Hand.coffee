class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> 
    @add(@deck.pop()).last()
    @trigger 'playerHit' unless @get 'isDealer'
    console.log @scores()  
    # debugger;
    if @scores()[0] == 21 
      @twentyOne()
    else if @scores()[0] > 21 
      @bust()

  stand: ->
    @trigger 'playerStand' unless @get 'isDealer'

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if hasAce then [score, score + 10] else [score]

  bust: ->
    console.log "hand: bust!"
    @trigger 'bust', @

  twentyOne: ->
    if @length == 2
      console.log "hand: black jack!"
      @trigger 'blackjack', @
    else
      console.log "hand: twenty one"
      @trigger 'twentyOne', @



