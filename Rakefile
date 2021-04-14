# frozen_string_literal: true

# ----------------------------------------------------
# Test the image's configuration on a Docker container
# ----------------------------------------------------
task test_image_config: [:build, :run, :cinc_auditor, :validate]

desc 'Build a Docker image on which to test configuration file'
task :build do
  sh 'docker build -t base:test .'
end

desc 'Run the Docker image'
task :run do
  sh 'docker run -d -i --name image base:test'
end

desc 'Run cinc-auditor against the image to validate the image\'s desired state'
task :cinc_auditor do
  sh 'bundle exec cinc-auditor exec ./test/integration/base_config -t docker://image'
end

desc 'Validate Packer script'
task :validate do
  sh 'packer validate ./Packerfile.pkr.hcl'
end

desc 'Build Packer'
task :packer do
    sh 'packer build -debug ./Packerfile.pkr.hcl'
end

desc 'Stop and remove build environments and containers'
task :destroy do
  sh 'docker container kill $(docker ps -q)'
  sh 'docker rm image'
end