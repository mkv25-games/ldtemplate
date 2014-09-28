module.exports = function(grunt) {

	var RELEASE_PATH = "../website/";
	var RELEASE_NAME_PREFIX = "LudumDareGame_r";
	var RELEASE_FILE = "release.ver";
	var BUILT_FILE_PATH = "../code/bin/flash/bin/LudumDareGame.swf";

	var INDEX_TEMPLATE_FILE = "../website/index.template.html";
	var INDEX_WRITE_FILE = "../website/index.html";
	
	function execute(command, onSuccess) {
		grunt.log.writeln("[INFO] Executing system command: " + command);

		var process = require("child_process").exec;
		var done = grunt.task.current.async();
		process(command, function(error, stdout, stderr) {
			done();
			if (!error) {
				if (onSuccess) {
					onSuccess.apply(grunt, [stdout, stderr]);
				}
			} else {
				grunt.fail.fatal("[BUILD ERROR] System command failed to execute: " + command + "\n" + stderr + "\n" + stdout);
			}
		});
	}

	function currentReleaseVersion() {
		var version = 0;
		if (grunt.file.exists(RELEASE_FILE)) {
			version = grunt.file.read(RELEASE_FILE);
		}
		return version;
	}
	
	grunt.registerTask("help", "Friendly information for first time users.", function() {
		var version = currentReleaseVersion();
		var NL = "\n";
		
		grunt.log.writeln("mkv25.net ludum dare release script");
		grunt.log.writeln("-----------------------------------");
		grunt.log.writeln("Current release version: " + version + ", next release version: " + (version + 1) + ".");
		grunt.log.writeln("Available commands: ");
		grunt.log.writeln("    help    - this info information");
		grunt.log.writeln(" ");
		grunt.log.writeln("    deploy  - bumps the release version" + NL
						+ "            - copies the release file" + NL
						+ "            - creates the index from template"
		);
		grunt.log.writeln(" ");
		grunt.log.writeln("    bump    - bumps the release version" + NL
						+ "            - tip: delete or edit " + RELEASE_FILE + " to set the number"
		);
		grunt.log.writeln(" ");
		grunt.log.writeln("    package - copies the release file" + NL
						+ "              from : " + BUILT_FILE_PATH + NL
						+ "              to   : " + RELEASE_PATH + NL
						+ "            - creates the index from template" + NL
						+ "              from : " + INDEX_TEMPLATE_FILE + NL
						+ "              to   : " + INDEX_WRITE_FILE + NL
		);
		grunt.log.writeln("    release - uploads the contents of the release folder.");
	});

	grunt.registerTask("check-release-version", "Check the release version file.", function() {
		var version;
		if (!grunt.file.exists(RELEASE_FILE)) {
			version = 1;
			grunt.log.writeln("[INFO] Creating " + RELEASE_FILE + " at version " + version);
			grunt.file.write(RELEASE_FILE, version);
		}

		version = currentReleaseVersion();
		grunt.log.writeln("[INFO] Current release version: " + version);
	});

	grunt.registerTask("bump-release-version", "Increment the release version file.", function() {
		var currentVersion = currentReleaseVersion();
		var newVersion = parseInt(currentVersion) + 1;
		grunt.log.writeln("[INFO] Bumping version from release version: " + currentVersion + " to " + newVersion);
		grunt.file.write(RELEASE_FILE, newVersion);
	});

	grunt.registerTask("package", "Package preview files for release.", function() {
		var releaseVersion = currentReleaseVersion();
		var releaseName = RELEASE_NAME_PREFIX + releaseVersion + ".swf";
		var releaseFilePath = RELEASE_PATH + releaseName;
		grunt.file.copy(BUILT_FILE_PATH, releaseFilePath);
		
		var template = grunt.file.read(INDEX_TEMPLATE_FILE);
		var index = template.replace(/TEMPLATED_OUTPUT_FILE/g, releaseName);
		grunt.file.write(INDEX_WRITE_FILE, index);
	});
}