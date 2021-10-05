fs = require 'fs'
readline = require 'readline'

exports.countryIpCounter = (countryCode, cb) ->
  return cb() unless countryCode

  readStream = readline.createInterface
    input: fs.createReadStream "#{__dirname}/../data/geo.txt", 'utf8'
    crfDelay: Infinity

  counter = 0
  lineCounter = 0

  readStream.on 'line', (line) ->
    field = line.split '\t'
    # GEO_FIELD_MIN, GEO_FIELD_MAX, GEO_FIELD_COUNTRY
    # line[0],       line[1],       line[3]

    if field[3] == countryCode
      counter += field[1] - field[0]
      lineCounter += 1

  readStream.on 'close', ->
    cb null, counter