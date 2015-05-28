'use strict';

module.exports = function(grunt) {

  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-release');
  grunt.loadNpmTasks('grunt-contrib-copy');

  grunt.initConfig({
    mochaTest: {
      test: {
        options: {
          reporter: 'spec',
          require: 'coffee-script'
        },
        src: ['test/**/*.coffee']
      }
    },
    release: {
      options: {
        tagName: 'v<%= version %>',
        commitMessage: 'Prepared to release <%= version %>.'
      }
    },
    watch: {
      files: ['Gruntfile.js', 'test/**/*.coffee'],
      tasks: ['test']
    },
    copy: {
      main: {
        files: [{
            expand: true,
            cwd: 'src/',
            src: ['**'],
            dest: 'node_modules/hubot/scripts/'
        }]
      }
    },
    shell: {
      hubot: {
        command: 'bin/hubot --name bot',
        options: {
          stderr: false,
          execOptions: {
              cwd: 'node_modules/hubot/'
          }
        }
      }
    }
  });

  grunt.event.on('watch', function(action, filepath, target) {
    grunt.log.writeln(target + ': ' + filepath + ' has ' + action);
  });

  // load all grunt tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  grunt.registerTask('test', ['mochaTest']);
  grunt.registerTask('test:watch', ['watch']);
  grunt.registerTask('default', ['test']);
  grunt.registerTask('hubot', ['copy', 'shell']);
};
