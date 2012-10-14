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
    window.editor.gotoLine 1 # should not always do this :/
    suffix = @model.get("path").match(/[^\.]+$/)[0]
    lang = window.LANGUAGE_MAP[suffix] || suffix
    window.editor.getSession().setMode("ace/mode/#{lang}")
    window.editor.focus()

  saveFile: () ->
    console.log "clicked bitch"

  open: (e) ->
    # return if $(e.target) != @$el.find(".file")[0]
    window.current_file = @model
    @setEditor()
    @model.open()
    @render()
    # do I need to reset on success?

  createFile: (e) ->
    if e.keyCode == 13
      path = "#{@model.collection.meta('path')}/#{$(e.currentTarget).val()}"
      window.current_file = @model # bind current file to the new model
      @model.set "path", path
      @model.upload()
      window.editExists = false
      @render()

  renderEdit: () ->
    @$el.html _.template @createTemplate, @model.toJSON() if !editExists
    window.editExists = true
    @
