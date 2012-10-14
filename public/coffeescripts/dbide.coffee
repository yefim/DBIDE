root = exports ? this

root.DBIDE =
  Models: {}
  Collections: {}
  Views: {}
  Templates: {}

String::display_name = () -> @match(/[^/]+$/)

root.editExists = false

$ ->
  root.editor = ace.edit("editor")
  editor.setTheme("ace/theme/monokai")
  editor.getSession().setUseSoftTabs(true)
  editor.getSession().setTabSize(2)
  editor.getSession().setMode("ace/mode/coffee")

  editor.commands.addCommand(
    name: 'save',
    bindKey: {win: 'Ctrl-S',  mac: 'Command-S'},
    exec: (editor) ->
      console.log('save')
  )
  editor.commands.addCommand(
    name: 'unbind-cr',
    bindKey: {win: 'Ctrl-R',  mac: 'Command-R'},
    exec: (editor) ->
  )
  editor.commands.addCommand(
    name: 'unbind-csr',
    bindKey: {win: 'Ctrl-Shift-R',  mac: 'Command-Shift-R'},
    exec: (editor) ->
  )

