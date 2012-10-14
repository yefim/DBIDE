class DBIDE.Views.EditView extends Backbone.View

  renderEdit: () ->
    @$el.html _.template @createTemplate, @model.toJSON() if !window.editExists
    window.editExists = true
    @

  unrenderEdit: () -> @$el.remove()
