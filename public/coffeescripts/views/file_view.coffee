class DBIDE.Views.FileView extends Backbone.View
  template: DBIDE.Templates.File # files only, no directories
  createTemplate: DBIDE.Templates.CreateFile

  initialize: () ->
    @model.on 'change', @setEditor

  events:
    "click .file"   : "open"
    "click #editor" : "saveFile"
    "keydown .new-file-name" : "createFile"

  render: () ->
    console.log "rendering single file"
    @$el.html _.template @template, @model.toJSON()
    @

  setEditor: () =>
    console.log @model.get("content")
    window.editor.setValue @model.get("content")
    window.editor.gotoLine 1

  saveFile: () ->
    console.log "clicked bitch"

  open: () ->
    # @current_file = @model
    # @current_file.open()
    @render()
    @setEditor()
    @model.open()

  createFile: (e) ->
    if e.keyCode == 13
      path = "#{@model.collection.meta('path')}/#{$(e.currentTarget).val()}"
      @model.set "path", path
      @model.upload()
      window.editExists = false
      @unrenderEdit()

  renderEdit: () ->
    @$el.html _.template @createTemplate, @model.toJSON() if !editExists
    window.editExists = true
    @

  unrenderEdit: () -> @$el.remove()
