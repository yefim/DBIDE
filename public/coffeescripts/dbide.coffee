root = exports ? this

root.DBIDE =
  Models: {}
  Collections: {}
  Views: {}
  Templates: {}

String::display_name = () -> @match(/[^/]+$/)

$ ->
  root.editor = ace.edit("editor")
  editor.getSession().setUseSoftTabs(true)
  editor.getSession().setTabSize(2)
  editor.getSession().setMode("ace/mode/coffee")
