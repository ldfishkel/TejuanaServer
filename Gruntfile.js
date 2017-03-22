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
    }
  });

  grunt.loadNpmTasks('grunt-mysql-runfile');

  grunt.registerTask('creation', ['mysqlrunfile:creation']);
  grunt.registerTask('proc', ['mysqlrunfile:proc']);
  grunt.registerTask('seed', ['mysqlrunfile:seed']);
  grunt.registerTask('empty', ['mysqlrunfile:empty']);
  grunt.registerTask('seedf', ['mysqlrunfile:seedf']);
  grunt.registerTask('deploy', ['mysqlrunfile:deploy']);

};