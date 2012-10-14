class DBIDE.Views.FileView extends Backbone.View
  template: DBIDE.Templates.File # files only, no directories
  createTemplate: DBIDE.Templates.CreateFile

  initialize: () ->
    @model.on 'all', @setEditor

  events:
    "click .file"   : "open"
    "click .file" : "openFile"
    "click #editor" : "saveFile"
    "keydown .new-file-name" : "createFile"

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

  renderEdit: () ->
    @$el.html _.template @createTemplate, @model.toJSON()
    @

  createFile: (e) ->
    if e.keyCode == 13
      path = "#{@model.collection.meta('path')}/#{$(e.currentTarget).val()}"
      @model.set "path", path
      @model.upload()
