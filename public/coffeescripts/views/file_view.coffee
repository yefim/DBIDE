class DBIDE.Views.FileView extends Backbone.View
  template: "" # files only, no directories
  initialize: () ->

  events:
    "click .file" : "openFile"

  render: () ->
    console.log "rendering single file"
    @$el.html ""
    @

  openFile: () ->
    @current_file = @
    @current_file.open()
