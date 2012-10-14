class DBIDE.Views.FileView extends Backbone.View
  template: DBIDE.Templates.File # files only, no directories
  initialize: () ->
    @model.on 'all', @setEditor

  events:
    "click .file"   : "open"
    "click #editor" : "saveFile"

  render: () ->
    console.log "rendering single file"
    @$el.html _.template @template, @model.toJSON()
    @

  setEditor: () =>
    editor.setValue @model.get("content")

  saveFile: () ->
    console.log "clicked bitch"

  open: () ->
    # @current_file = @model
    # @current_file.open()
    @model.open()
