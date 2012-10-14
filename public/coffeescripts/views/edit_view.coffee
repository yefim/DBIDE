class DBIDE.Views.EditView extends Backbone.View

  renderEdit: () ->
    @$el.html _.template @createTemplate, @model.toJSON() if !editExists
    window.editExists = true
    @
