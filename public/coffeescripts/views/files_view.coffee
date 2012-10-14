class DBIDE.Views.FilesView extends DBIDE.Views.EditView
  template: DBIDE.Templates.Files # need arrow in files template >Project1

  initialize: () ->
    @collection.on 'reset', @render

  events:
    "click .folder" : "expand"
    "click .new-file" : "newFile"

  render: () =>
    @$el.html _.template @template, @collection._meta
    views = []
    @collection.each (file) ->
      # if file.is_dir recurse!!
      if file.get("is_dir")
        console.log file.toJSON()
        files_collection = new DBIDE.Collections.FilesCollection()
        files_collection.meta("is_dir", true)
        files_collection.meta("expanded", false)
        files_collection.meta("path", file.get("path"))
        view = new DBIDE.Views.FilesView(collection: files_collection)
        views.push view.render()
      else
        view = new DBIDE.Views.FileView(model: file)
        views.push view.render()
    viewEls = _.pluck _.values(views), 'el'
    @$el.find(".files").html viewEls
    @

  expand: (e) ->
    return if e.target != @$el.find(".folder")[0]
    @collection.meta("expanded", true)
    @collection.open()
    window.editExists = false

  newFile: () ->
    file = new DBIDE.Models.File()
    @collection.add file
    view = new DBIDE.Views.FileView(model: file)
    @$el.find(".files").append view.renderEdit().el
    window.editExists = true

  renderEdit: () ->
    @$el.html _.template @createTemplate, @model.toJSON() if !editExists
    window.editExists = true
    @

  unrenderEdit: () -> @$el.remove()
