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
      view = new DBIDE.Views.FileView(model: file)
      views.push view.render()
    viewEls = _.pluck _.values(views), 'el'
    # @.$(".contents").append viewEls
    @$el.find(".files").html viewEls
    @

  expand: () -> 
    @collection.open()
    window.editExists = false

  newFile: () ->
    file = new DBIDE.Models.File()
    @collection.add file
    view = new DBIDE.Views.FileView(model: file)
    @$el.find(".files").append view.renderEdit().el
    
