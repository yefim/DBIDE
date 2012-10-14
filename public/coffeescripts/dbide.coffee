root = exports ? this

root.DBIDE =
  Models: {}
  Collections: {}
  Views: {}
  Templates: {}

String::display_name = () -> @match(/[^/]+$/)[0]

root.editExists = false

root.LANGUAGE_MAP =
  "js"     : "javascript"
  "py"     : "python"
  "rb"     : "ruby"

$ ->
  root.editor = ace.edit("editor")
  editor.setTheme("ace/theme/monokai")
  editor.getSession().setUseSoftTabs(true)
  editor.getSession().setTabSize(2)

  suffix = window.current_file.get("path").match(/[^\.]+$/)[0]
  lang = LANGUAGE_MAP[suffix] || suffix
  editor.getSession().setMode("ace/mode/#{lang}")

  editor.focus()

  editor.commands.addCommand(
    name: 'save',
    bindKey: {win: 'Ctrl-S',  mac: 'Command-S'},
    exec: (editor) ->
      # time-stamp should show
      window.current_file.set "content", editor.getValue()
      window.current_file.upload()
      return true # required
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

