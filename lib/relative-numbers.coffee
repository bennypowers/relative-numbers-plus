LineNumberView = require './line-number-view'
{CompositeDisposable} = require 'atom'

module.exports =
  # Config schema
  config:
    delayedMotion:
      type: 'boolean'
      default: false
      description: 'Delay the motion to reduce the CPU load.'
    trueNumberCurrentLine:
      type: 'boolean'
      default: true
      description: 'Show the absolute line number on the current line'
    showAbsoluteNumbers:
      type: 'boolean'
      default: false
      description: 'Show both absolute and relative line numbers at all times'
    startAtOne:
      type: 'boolean'
      default: false
      description: 'Start relative line numbering at one instead of zero for the current line'
    softWrapsCount:
      type: 'boolean'
      default: true
      description: 'Do soft-wrapped lines count? (No in vim-mode-plus, yes in vim-mode)'
    showAbsoluteNumbersInInsertMode:
      type: 'boolean'
      default: true
      description: 'Revert back to absolute numbers while in insert mode (vim-mode/vim-mode-plus)'

  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.workspace.observeTextEditors (editor) ->
      if not editor.gutterWithName('relative-numbers')
        new LineNumberView(editor)

  deactivate: () ->
    @subscriptions.dispose()
    for editor in atom.workspace.getTextEditors()
      editor.gutterWithName('relative-numbers').view?.destroy()
