#! /usr/bin/env ruby

plugin = File.basename(File.expand_path('.'))
spec = Gem::Specification.load("#{ plugin }.gemspec")
lib = File.expand_path('../lib')
version_file = "lib/#{ plugin }/version.rb"
github_org = ''

$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require_relative "../../#{ plugin }/lib/#{ plugin }"
require 'date'
require 'json'
require 'base64'

## Environment Setup

# Drop the necessary keys into the build environment.
# Environment variables are not used due to the design of codeship, each project
# has its own set of variables so a key would need to be added or changed
# in ~160 repos and that just unpleasent to think about.
`key_deploy`

# the following chmod commands will go away when I can give Golang
# some more love
`chmod 0600 /home/rof/.gem/credentials`
`chmod 0600 /home/rof/.ssh/github_auto_key`
`chmod 0600 /home/rof/.ssh/gem-private_key.pem`
`chmod 0600 /home/rof/.ssh/git_token`

# This is needed for codeship as it checkouts a local branch, we want to
# ensure that we commit back up to master.
# The user.name maps to a Github machine user and the email is not necessary
`git checkout master`
`git fetch origin "+refs/heads/*:refs/remotes/origin/*"`
`git remote add repo git@github.com:sensu-plugins/#{ plugin }.git`
`git config --global user.email 'no-op@example.com'`
`git config --global user.name 'sensu-plugin'`

# set the git api token
github_token = File.read('/home/rof/.ssh/git_token')

#
# Build a gem and deploy it to rubygems
#
def deploy_rubygems(spec, plugin)
  `gem build #{ plugin }.gemspec`
  `gem push #{ spec.full_name }.gem`
end

#
# Create Github tag and release
#
def create_github_release(spec, plugin)
  `curl -H "Authorization: token #{ github_token }" -d '{ "tag_name": "#{ spec.version }", "target_commitish": "#{ ENV['CI_COMMIT_ID'] }", "name": "#{ spec.version }", "body": "#{ ENV['CI_MESSAGE'] }", "draft": "#{ spec.metadata['release_draft']}", "prerelease": "#{ spec.metadata['release_prerelease']}" }' https://api.github.com/repos/#{ github_org }/#{ plugin }/releases` # rubocop:disable all
end

#
# Bump the patch version of the plugin
#
def version_bump(version_file)
  # Read the file, bump the PATCH version
  contents = File.read(version_file).gsub(/(PATCH = )(\d+)/) { |_| Regexp.last_match[1] + (Regexp.last_match[2].to_i + 1).to_s }

  # Write the new contents of the file
  File.open(version_file, 'w') { |file| file.puts contents }
end

# create a github commit for the version bump
# the skip-ci flag is specific to codeship to prevent this from being run as a test
# Travis-CI will still run it as a test though
#
def create_github_commit(plugin)
  `git add lib/#{ plugin }/version.rb`
  `git commit -m 'version bump --skip-ci'`
  `git push repo master`
end

end

if ENV['CI_MESSAGE'] == 'deploy'
  version_bump(version_file)
  create_github_commit(plugin)
  deploy_rubygems(spec, plugin)
  create_github_release(spec, plugin)
end
