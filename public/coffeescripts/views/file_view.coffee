class DBIDE.Views.FileView extends Backbone.View
  template: DBIDE.Templates.File # files only, no directories
  createTemplate: DBIDE.Templates.CreateFile

  initialize: () ->

  events:
    "click .file" : "openFile"
    "keydown .new-file-name" : "createFile"

  render: () ->
    console.log "rendering single file"
    @$el.html _.template @template, @model.toJSON()
    @

  renderEdit: () ->
    @$el.html _.template @createTemplate, @model.toJSON()
    @

  openFile: () ->
    @current_file = @
    @current_file.open()

  createFile: (e) ->
    console.log @model.collection.meta("path")
    if e.keyCode == 13
      path = "#{@model.collection.meta('path')}/#{$(e.currentTarget).val()}"
      @model.set "path", path
      @model.upload()
    console.log "created"