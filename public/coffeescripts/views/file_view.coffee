class DBIDE.Views.FileView extends Backbone.View
  template: DBIDE.Templates.File # files only, no directories
  createTemplate: DBIDE.Templates.CreateFile

  initialize: () ->
    @model.on 'change', @setEditor

  events:
    "click .file"            : "open"
    "click #editor"          : "saveFile"
    "keydown .new-file-name" : "createFile"

  render: () ->
    @$el.html _.template @template, @model.toJSON()
    @

  setEditor: () =>
    window.editor.setValue @model.get("content")
    window.editor.gotoLine 1
    window.editor.focus()

  saveFile: () ->
    console.log "clicked bitch"

  open: (e) ->
    # return if $(e.target) != @$el.find(".file")[0]
    window.current_file = @model
    @setEditor()
    @model.open()
    # do I need to reset on success?

  createFile: (e) ->
    if e.keyCode == 13
      path = "#{@model.collection.meta('path')}/#{$(e.currentTarget).val()}"
      @model.set "path", path
      @model.upload()
      window.editExists = false
      @render()

  renderEdit: () ->
    @$el.html _.template @createTemplate, @model.toJSON() if !editExists
    window.editExists = true
    @
