# frozen_string_literal: true

control 'packages' do
  desc 'All packages are installed'
  %w[
    unzip
    curl
    chrony
    azure-cli
  ].each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end
end

control 'binaries' do
  desc 'Commands for installed binaries exist'
  describe command('jq') do
    it { should exist }
  end
end