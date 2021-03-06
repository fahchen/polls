class App.Views.Question extends Backbone.View
  tagName: 'div'
  className: "question",

  multipleId: (value) ->
    "multiple_#{value}_#{@cid}"
  multipleName: () ->
    "multiple[#{@cid}]"


  template: App.Templates.Question

  events:
    'click .js-remove-question': 'removeQuestion'
    'click .js-toggle-question': 'toggleQuestion'

  render: () ->
    @listenTo(@model, 'remove', @remove)

    @$el.html @template(@model.attributes)

    @$title = @$('.input')
    @$title.change () =>
      @model.set title: @$title.val().trim()

    @$el.append @choicesView().el

    @$choicesBody = @$('.choices')

    @

  choicesView: () ->
    new App.Views.Choices
      collection: @model.get('choices')

  initMultiple: () ->
    Polls.initiCheck @$('.multiple input')
    @setMultiple()

  setMultiple: () ->
    if @model.get('multiple')
      $("##{@multipleId(true)}").iCheck('check')
    else
      $("##{@multipleId(false)}").iCheck('check')
    @$('.multiple input').on 'ifChecked', (event)=>
      value = not not parseInt($(event.target).val())
      @model.set multiple: value


  # Events
  removeQuestion: (e) ->
    e.stopPropagation()

    @$el.slideUp 'fast', () =>
      @model.collection.remove(@model)

  toggleQuestion: (e) ->
    e.stopPropagation()

    @$choicesBody.slideToggle()
    @$('.js-toggle-question').toggleClass('fa-angle-up')
    @$('.js-toggle-question').toggleClass('fa-angle-down')

