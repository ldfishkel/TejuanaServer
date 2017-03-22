'use strict';

module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    mysqlrunfile: {
    
      options: {
        connection: {
            host: 'localhost',
            user: 'root',
            password: 'root',
            database: 'Tejuana',
            multipleStatements: true
        }
      },
    
      creation: {
        src: ['sql/creation.sql']
      },
    
      proc: {
        src: ['sql/procedures/*']
      },
    
      seed: {
        src: ['sql/seed.sql']
      },
    
      empty: {
        src: ['sql/creation.sql', 'sql/procedures/*']
      },
    
      seedf: {
        src: ['sql/creation.sql', 'sql/seed.sql']
      },
    
      deploy: {
        src: ['sql/creation.sql', 'sql/seed.sql', 'sql/procedures/*']
      }
    },

    spawn: {
      webstart: {
        command: 'python',
        commandArgs: ['router.py'],
        directory: './',
        groupFiles: true, 
        passThrough: false,
        pattern: 'http',
        opts: {
          stdio: 'inherit',
          cwd: __dirname + '/'
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-mysql-runfile');
  grunt.loadNpmTasks('grunt-spawn');
  
  grunt.registerTask('creation', ['mysqlrunfile:creation']);
  grunt.registerTask('proc', ['mysqlrunfile:proc']);
  grunt.registerTask('seed', ['mysqlrunfile:seed']);
  grunt.registerTask('empty', ['mysqlrunfile:empty']);
  grunt.registerTask('seedf', ['mysqlrunfile:seedf']);
  grunt.registerTask('deploy', ['mysqlrunfile:deploy', 'spawn:webstart']);
  grunt.registerTask('run', ['spawn:webstart']);

};