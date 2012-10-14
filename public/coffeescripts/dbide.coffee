root = exports ? this

root.DBIDE =
  Models: {}
  Collections: {}
  Views: {}
  Templates: {}

String::display_name = () -> @match(/[^/]+$/)

$ ->
  editor = ace.edit("editor")
