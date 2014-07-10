module.exports = (grunt) ->

  require('load-grunt-tasks') grunt

  grunt.initConfig

    watch:
      jade:
        files: ['src/views/*.jade']
        tasks: ['jade']
      stylus:
        files: ['src/styles/*.styl']
        tasks: ['stylus']
      coffee:
        files: ['src/scripts/*.coffee']
        tasks: ['coffee', 'uglify:compile']

    jade:
      compile:
        files:
          'index.html': 'src/views/index.jade'

    stylus:
      compile:
        options:
          'include css': true
          paths: ['bower_components/normalize.css']
          import: [
            'nib'
            'normalize.css'
            'iconfont.css'
          ]
        files:
          'styles/index.css': 'src/styles/index.styl'

    coffee:
      compile:
        files:
          '.tmp/scripts/index.js': 'src/scripts/index.coffee'

    uglify:
      vendor:
        src: [
          'bower_components/jquery/dist/jquery.js'
          'bower_components/cropit/dist/jquery.cropit.js'
        ]
        dest: 'scripts/vendor.js'
      compile:
        options:
          mangle: true
          compress: true
        src: [
          '.tmp/scripts/index.js'
        ]
        dest: 'scripts/index.js'

    coffeelint:
      all: [
        'Gruntfile.coffee'
        'src/scripts/*.coffee'
      ]
      options:
        max_line_length: level: 'ignore'
        indentation: level: 'ignore'

    copy:
      font:
        files: [
          expand: true
          cwd: 'src/styles/fonts'
          src: ['*']
          dest: 'styles/fonts'
        ]

    clean:
      tmp: '.tmp'

  grunt.registerTask 'build', [
    'coffeelint'
    'jade'
    'stylus'
    'coffee'
    'uglify'
    'clean'
  ]

  grunt.registerTask 'default', [
    'build'
  ]
