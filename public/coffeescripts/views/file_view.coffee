class DBIDE.Views.FileView extends Backbone.View
  template: DBIDE.Templates.File # files only, no directories
  initialize: () ->

  events:
    "click .file" : "openFile"

  render: () ->
    console.log "rendering single file"
    @$el.html _.template @template, @model.toJSON()
    @

  openFile: () ->
    @current_file = @
    @current_file.open()
