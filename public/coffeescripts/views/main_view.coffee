class DBIDE.Views.MainView extends Backbone.View
  template: DBIDE.Templates.Main # underscorejs template for the outer wrapper?

  initialize: (options) ->
    @projects = []
    @current_file = new DBIDE.Models.File()
    for project in options.projects
      console.log project
      files_collection = new DBIDE.Collections.FilesCollection()
      files_collection.meta("is_dir", true)
      files_collection.meta("path", project)
      # find the current file and set current_file = true for rendering
      @projects.push files_collection
    # initialize the current file
    # should just be a pointer to a file in one of the files_collection, to avoid fetching
    # or it could just be it's own model, however, it will need to be fetched every time
    @current_file.on 'change', @render
    @render()

  events:
    "click .new-folder" : "newFolder"
  
  render: () ->
    $("#filebrowser").html _.template @template
    # Render the projects file browser first
    views = []
    for files_collection in @projects
      view = new DBIDE.Views.FilesView(collection: files_collection)
      views.push view.render()
    viewEls = _.pluck _.values(views), 'el'
    $(".root").html viewEls
    # Now render the current file
    # $("#editor").html @current_file.contents
    # set editor language to new language?

  newFolder: () ->
    console.log "clicked"
    view = new DBIDE.Views.FilesView()
    @$el.find(".root").append view.renderEdit().el