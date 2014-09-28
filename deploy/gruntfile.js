module.exports = function(grunt) {

	// the ludum ID, expressed as lowercase ld##
	var LDID = "ldtemplate";

	// ftp host
	var FTP_HOST = 'ftp.mkv25.net';
	var FTP_USER = 'grunt-ludum'
	var FTP_PATH = '';

	// load plugins
	grunt.loadNpmTasks('grunt-ftp-deploy');
	grunt.loadNpmTasks('grunt-debug-task');

	// Project configuration.
	grunt.initConfig({
		pkg: grunt.file.readJSON('package.json'),

		"ftp-deploy": {
			preview: {
				auth: {
					host: FTP_HOST,
					port: 21,
					authKey: FTP_USER
				},
				src: '../website/',
				dest: FTP_PATH + LDID + '/preview',
				exclusions: []
			},
			release: {
				auth: {
					host: FTP_HOST,
					port: 21,
					authKey: FTP_USER
				},
				src: '../release/',
				dest: FTP_PATH + LDID + '/release',
				exclusions: []
			}
		}
	});

	// Load local tasks
	require('./deployment-tasks.js')(grunt);

	// Default task(s).
	grunt.registerTask('default', ["help"]);
	grunt.registerTask('bump', ['bump-release-version']);
	grunt.registerTask('deploy', ['bump', 'package', 'ftp-deploy:preview']);
	grunt.registerTask('release', ['ftp-deploy:release']);
}
