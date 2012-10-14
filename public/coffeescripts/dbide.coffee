root = exports ? this

root.DBIDE =
  Models: {}
  Collections: {}
  Views: {}

$ ->
  editor = ace.edit("editor")
  # initialize mainview in here or in index.erb
