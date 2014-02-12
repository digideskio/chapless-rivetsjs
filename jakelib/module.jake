// Tasks to add modules to the project that are not included by default.
// This is usually either Bower packages or module-based Scaffolt generators.
var generators = require('./lib').generators;
var jsonfile = require('jsonfile');
var npm = require('./lib').bin('npm');

namespace('add', function() {
  desc('Add support for testing (code/site)');
  task('testing', ['add:codetesting', 'add:sitetesting']);

  desc('Add support for code testing');
  task('codetesting', function() {
    editBower(function() {
      this.dependencies.chai = '~1.9.0';
      this.dependencies.mocha = '~1.17.1';
      this.dependencies.sinon = 'http://sinonjs.org/releases/sinon-1.7.3.js';
      this.dependencies['sinon-chai'] = '~2.5.0';
      this.overrides.mocha = {
        "main": [
          "mocha.css",
          "mocha.js"
        ]
      };
      this.overrides['sinon-chai'] = {
        "main": "lib/sinon-chai.js",
        "dependencies": {
          "sinon": "*",
          "chai": "*"
        }
      };
    });
    editPackage(function() {
      this.devDependencies.karma = '~0.10.9';
      this.devDependencies['karma-chai-plugins'] = '~0.2.0';
      this.devDependencies['karma-mocha'] = '~0.1.1';
    });
    return npm.execute('install');
  });

  desc('Add support for site testing');
  task('sitetesting', function() {
    editPackage(function() {
      this.devDependencies.chai = '~1.9.0';
      this.devDependencies.mocha = '~1.17.1';
      this.devDependencies['mocha-as-promised'] = '~2.0.0';
      this.devDependencies.nodemon = '~1.0.14';
      this.devDependencies['selenium-webdriver'] = '~2.39.0';
    });
    return npm.execute('install');
  });

  desc('Add Prerender');
  task('prerender', function() {
    editPackage(function() {
      this.dependencies.prerender = '~2.0.1';
      this.dependencies['prerender-node'] = '~0.1.15';
    });
    return npm.execute('install');
  });

  desc('Add jQuery');
  task('jquery', function() {
    editBower(function() {
      this.dependencies.jquery = '~2.1.0';
    });
  });

  desc('Add normalize.css');
  task('normalize', function() {
    editBower(function() {
      this.dependencies['normalize-css'] = '~3.0.0';
    });
  });

  desc('Add Lo-Dash');
  task('lodash', function() {
    editBower(function() {
      this.dependencies.lodash = '~2.4.1';
    });
  });

  desc('Add Rivets for better view/model data binding');
  task('rivets', function() {
    editBower(function() {
      this.dependencies.rivets = '~0.6.4';
      this.overrides.rivets = {
        main: 'dist/rivets.js'
      };
    });
  });

  desc('Add Exoskeleton (replaces Backbone, removes jQuery and Lodash)');
  task('exoskeleton', ['rem:jquery', 'rem:lodash'], function() {
    editBower(function() {
      this.dependencies.exoskeleton = '~0.6.1';
      this.overrides.chaplin = {
        dependencies: {
          exoskeleton: '*'
        }
      };
      delete this.overrides.backbone;
    });
  });

  desc('Add Davy for promise support (useful with Exoskeleton)');
  task('davy', function() {
    editBower(function() {
      this.dependencies.davy = '~0.1.0';
    });
  });
});

namespace('rem', function() {
  desc('Remove support for testing (code/site)');
  task('testing', ['rem:codetesting', 'rem:sitetesting']);

  desc('Remove support for code testing');
  task('codetesting', function() {
    editBower(function() {
      delete this.dependencies.chai;
      delete this.dependencies.mocha;
      delete this.dependencies.sinon;
      delete this.dependencies['sinon-chai'];
      delete this.overrides.mocha;
      delete this.overrides['sinon-chai'];
    });
    return npm.execute('uninstall',
      'karma',
      'karma-chai-plugins',
      'karma-mocha',
      '--save-dev');
  });

  desc('Remove support for site testing');
  task('sitetesting', function() {
    return npm.execute('uninstall',
      'chai',
      'mocha',
      'mocha-as-promised',
      'nodemon',
      'selenium-webdriver',
      '--save-dev');
  });

  desc('Remove Prerender');
  task('prerender', function() {
    return npm.execute('uninstall', 'prerender', 'prerender-node', '--save');
  });

  desc('Remove jQuery');
  task('jquery', function() {
    editBower(function() {
      delete this.dependencies.jquery;
    });
  });

  desc('Remove normalize.css');
  task('normalize', function() {
    editBower(function() {
      delete this.dependencies['normalize-css'];
    });
  });

  desc('Remove Lo-Dash');
  task('lodash', function() {
    editBower(function() {
      delete this.dependencies.lodash;
    });
  });

  desc('Remove Rivets');
  task('rivets', function() {
    editBower(function() {
      delete this.dependencies.rivets;
      delete this.overrides.rivets;
    });
  });

  desc('Remove Exoskeleton (restores classic Backbone, jQuery, and Lo-Dash)');
  task('exoskeleton', ['add:jquery', 'add:lodash'], function() {
    editBower(function() {
      this.overrides.backbone = {
        dependencies: {
          lodash: '*',
          jquery: '*'
        },
        main: 'backbone.js'
      };
      delete this.dependencies.exoskeleton;
      delete this.overrides.chaplin;
    });
  });

  desc('Remove Davy');
  task('davy', function() {
    editBower(function() {
      delete this.dependencies.davy;
    });
  });
});

function editBower(callback) {
  var json = jsonfile.readFileSync('bower.json');
  callback.call(json);
  jsonfile.writeFileSync('bower.json', json);
}

function editPackage(callback) {
  var json = jsonfile.readFileSync('package.json');
  callback.call(json);
  jsonfile.writeFileSync('package.json', json);
}
