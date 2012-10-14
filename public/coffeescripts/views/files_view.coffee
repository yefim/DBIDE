class DBIDE.Views.FilesView extends Backbone.View
  template: DBIDE.Templates.Files # need arrow in files template >Project1
  initialize: () ->
    @collection.on 'reset', @render

  events:
    "click .folder" : "expand"

  render: () =>
    console.log @collection._meta
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
    console.log "expanded"
    @collection.open()
    console.log @collection
