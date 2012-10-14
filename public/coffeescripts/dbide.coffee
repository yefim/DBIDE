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
  $(".editor-button").on "click", (e) ->
    $(".editor-button").removeClass("selected")
    $(e.target).addClass("selected")
    mode = $(e.target).text().toLowerCase()
    if mode == "normal"
      window.editor.setKeyboardHandler(null)
    else
      mode = "ace/keyboard/#{mode}"
      window.editor.setKeyboardHandler(require(mode).handler)
    window.editor.focus()
    $.ajax(
      type: "POST",
      url: "/mode",
      data: {mode: mode}
    )

  root.editor = ace.edit("editor")
  editor.setTheme("ace/theme/monokai")
  editor.getSession().setUseSoftTabs(true)
  editor.getSession().setTabSize(2)
  if MODE.length
    editor.setKeyboardHandler(require(MODE).handler)
  else
    editor.setKeyboardHandler(null)

  if window.current_file.get("path")
    suffix = window.current_file.get("path").match(/[^\.]+$/)[0]
    lang = LANGUAGE_MAP[suffix] || suffix
    editor.getSession().setMode("ace/mode/#{lang}") # if lang is not a real lang, it fucks up a bit

  editor.focus()

  editor.commands.addCommand(
    name: 'save',
    bindKey: {win: 'Ctrl-S',  mac: 'Command-S'},
    exec: (editor) ->
      # time-stamp should show
      window.current_file.set({"content": editor.getValue()},
        silent: true
      )
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

