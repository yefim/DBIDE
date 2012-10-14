class DBIDE.Models.File extends Backbone.Model
  defaults:
    name: null
    project: null
    path: null
    current: false
    content: null # this could be a method

  upload: () ->
    @url = '/save'
    @save()

  open: () ->

class DBIDE.Collections.FilesCollection extends Backbone.Collection
  model: DBIDE.Models.File
  
  defaults:
    name: null
    project: null
    path: null

  new: () ->

  open: () ->
