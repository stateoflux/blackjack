class window.HandView extends Backbone.View

  className: 'hand'

  #todo: switch to mustache
  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2><p class="message"></p>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    # @collection.on 'bust', @setLoseMessage, @
    # @collection.on 'win', @setWinMessage, @
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.scores()[0]

  # setLoseMessage: ->
  #   who = if @collection.isDealer? then "Dealer" else "Player"
  #   @$el.find('p').html("#{who} Loses")

  # setWinMessage: ->
  #   who = if @collection.isDealer? then "Dealer" else "Player"
  #  @$el.find('p').html("#{who} Wins")

