class DBIDE.Views.FileView extends Backbone.View
  template: "" # files only, no directories
  initialize: () ->

  events:
    "click .file" : "openFile"

  render: () ->
    @$el.html ""
    @

  openFile: () ->
    @current_file = @
    @current_file.open()
