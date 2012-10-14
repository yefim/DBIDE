class DBIDE.Views.FilesView extends Backbone.View
  template: "" # need arrow in files template >Project1
  initialize: () ->

  render: () ->
    views = []
    @collection.each (file) ->
      # if file.is_dir recurse!!
      view = new DBIDE.Views.FileView(model: file)
      views.push view.render()
    viewEls = _.pluck _.values(views), 'el'
    # @.$(".contents").append viewEls
    @$el.html viewEls
    @
