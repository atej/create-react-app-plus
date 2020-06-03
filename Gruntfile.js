module.exports = function(grunt) {

  const options = {
    separator: '\n\n',
    footer: '\n'
  };

	grunt.initConfig({
		concat: {
      craPlus: {
        options,
        src: [
          'src/sh/partials/_use-bash.sh',
          'src/sh/vars/_colors.sh',
          'src/sh/vars/_eslint_version.sh',
          'src/sh/partials/_comment-prompts.sh',
          'src/sh/partials/_prompt-package_manager.sh',
          'src/sh/partials/_prompt-file_format.sh',
          'src/sh/partials/_prompt-write_eslintrc.sh',
          'src/sh/partials/_prompt-line_length.sh',
          'src/sh/partials/_prompt-write_prettierrc.sh',
          'src/sh/partials/_prompt-express_api.sh',
          'src/sh/partials/_prompt-tailwind.sh',
          'src/sh/partials/_prompt-proptypes.sh',
          'src/sh/partials/_prompt-faker.sh',
          'src/sh/partials/_prompt-axios.sh',
          'src/sh/partials/_comment-configure.sh',
          'src/sh/partials/_start-configure.sh',
          'src/sh/partials/_configure-eslint-prettier-vscode.sh',
          'src/sh/partials/_configure-index_js.sh',
          'src/sh/partials/_configure-express_api.sh',
          'src/sh/partials/_configure-tailwind.sh',
          'src/sh/partials/_configure-proptypes.sh',
          'src/sh/partials/_configure-faker.sh',
          'src/sh/partials/_configure-axios.sh',
          'src/sh/partials/_end-configure.sh',
        ],
        dest: 'create-react-app-plus.sh'
      },
      lintAndFormat: {
        options,
        src: [
          'src/sh/partials/_use-bash.sh',
          'src/sh/vars/_colors.sh',
          'src/sh/vars/_eslint_version.sh',
          'src/sh/partials/_comment-prompts.sh',
          'src/sh/partials/_prompt-package_manager.sh',
          'src/sh/partials/_prompt-file_format.sh',
          'src/sh/partials/_prompt-write_eslintrc.sh',
          'src/sh/partials/_prompt-line_length.sh',
          'src/sh/partials/_prompt-write_prettierrc.sh',
          'src/sh/partials/_comment-configure.sh',
          'src/sh/partials/_start-configure.sh',
          'src/sh/partials/_configure-eslint-prettier-vscode.sh',
          'src/sh/partials/_configure-index_js.sh',
          'src/sh/partials/_end-configure.sh',
        ],
        dest: 'scripts/eslint-prettier-vscode.sh'
      },
      expressAPI: {
        options,
        src: [
          'src/sh/partials/_use-bash.sh',
          'src/sh/vars/_colors.sh',
          'src/sh/partials/_comment-prompts.sh',
          'src/sh/partials/_prompt-package_manager.sh',
          'src/sh/partials/_prompt-express_api.sh',
          'src/sh/partials/_comment-configure.sh',
          'src/sh/partials/_start-configure.sh',
          'src/sh/partials/_configure-express_api.sh',
          'src/sh/partials/_end-configure.sh',
        ],
        dest: 'scripts/express-api.sh'
      },
      tailwind: {
        options,
        src: [
          'src/sh/partials/_use-bash.sh',
          'src/sh/vars/_colors.sh',
          'src/sh/partials/_comment-prompts.sh',
          'src/sh/partials/_prompt-package_manager.sh',
          'src/sh/partials/_prompt-tailwind.sh',
          'src/sh/partials/_comment-configure.sh',
          'src/sh/partials/_start-configure.sh',
          'src/sh/partials/_configure-tailwind.sh',
          'src/sh/partials/_end-configure.sh',
        ],
        dest: 'scripts/tailwind.sh'
      },
      readme: {
        options,
				src: [
          'src/md/readme/_features.md',
          'src/md/readme/_installation.md',
          'src/md/readme/_packages.md',
          'src/md/readme/_configuration-intro.md',
          'src/md/readme/_configuration-eslint.md',
          'src/md/readme/_configuration-prettier.md',
          'src/md/readme/_configuration-vscode.md',
          'src/md/readme/_configuration-express-api.md',
          'src/md/readme/_configuration-tailwind.md',
          'src/md/readme/_divider.md',
          'src/md/readme/_origin-story.md',
          'src/md/readme/_prior-art.md'
        ],
				dest: 'README.md'
      },
		}

	});

	grunt.loadNpmTasks('grunt-contrib-concat');

	grunt.registerTask('default', ['concat']);
};