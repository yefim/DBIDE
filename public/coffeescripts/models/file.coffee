class DBIDE.Models.File extends Backbone.Model
  defaults:
    path: null
    current: false
    content: null # this could be a method

  upload: () ->
    @url = '/save'
    @save()

  open: () ->
    @url = '/open'
    @fetch(
      data: $.param @toJSON()
    )

class DBIDE.Collections.FilesCollection extends Backbone.Collection
  model: DBIDE.Models.File

  initialize: () ->
    @_meta = {}

  meta: (prop, value) ->
    if !value?
      return @_meta[prop]
    else
      @_meta[prop] = value

  open: () ->
    @url = '/open'
    @fetch(
      data: $.param @_meta
    )
