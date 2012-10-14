root = exports ? this

root.DBIDE =
  Models: {}
  Collections: {}
  Views: {}

String::display_name = () -> @match(/[^/]+$/)

$ ->
  editor = ace.edit("editor")