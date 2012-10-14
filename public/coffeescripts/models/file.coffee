class DBIDE.Models.File extends Backbone.Model
  defaults:
    is_dir: false
    name: null
    project: null
    path: null
    current: false
    content: null # this could be a method

  upload: () ->
    @url = '/save'
    @save()

  open: () ->
    @url = '/open'
    @fetch(
      data: $.params @toJSON()
    )

class DBIDE.Collections.FilesCollection extends Backbone.Collection
  model: DBIDE.Models.File
  
  defaults:
    is_dir: true
    name: null
    project: null
    path: null

  open: () ->
    @url = '/open'
    @fetch(
      data: $.params @toJSON()
    )
