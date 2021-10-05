through2 = require 'through2'


module.exports = ->
  words = 0
  lines = 1

  transform = (chunk, encoding, cb) ->
    lines = chunk.split(/\r\n|\r|\n/).length

    tokens = chunk.split(' ')

    # Replace sentances strating starting and ending with double quotes with 'word'
    # Raplace CamelCase words with 'word word'
    tokens = chunk.replace(/("[^"]*")/g, 'word').replace(/([a-zA-Z])([A-Z])/g, 'word word').match(/[a-zA-Z0-9]+/gm)

    words = tokens.length
    return cb()

  flush = (cb) ->
    this.push {words, lines}
    this.push null
    return cb()

  return through2.obj transform, flush
