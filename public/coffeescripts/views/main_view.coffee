class DBIDE.Views.MainView extends Backbone.View
  initialize: () ->
    @projects = []
    for project in options.projects
      project_collection = new DBIDE.Collection.FilesCollection()
      project_collection.reset project
      @projects.push project_collection
  
  render: () ->
