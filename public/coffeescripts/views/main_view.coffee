class DBIDE.Views.MainView extends Backbone.View
  template: DBIDE.Templates.Main

  initialize: (options) ->
    @projects = []
    for project in options.projects
      files_collection = new DBIDE.Collections.FilesCollection()
      files_collection.meta("is_dir", true)
      files_collection.meta("expanded", false)
      files_collection.meta("path", project)
      @projects.push files_collection
    window.current_file.on 'selected', @render
    @render()

  events:
    "click .new-folder pull-right" : "newFolder"
  
  render: () =>
    console.log "selected changed"
    $("#filebrowser").html _.template @template
    # Render the projects file browser first
    views = []
    for files_collection in @projects
      view = new DBIDE.Views.FilesView(collection: files_collection)
      views.push view.render()
    viewEls = _.pluck _.values(views), 'el'
    $(".root").html viewEls

  newFolder: () ->
    console.log "clicked"
    files_collection = new DBIDE.Collections.FilesCollection()
    files_collection.meta("is_dir", true)
    files_collection.meta("expanded", false)
    view = new DBIDE.Views.FilesView(collection: files_collection)
    @$el.find(".root").append view.renderEdit().el
