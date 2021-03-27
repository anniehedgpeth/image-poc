%w(
  unzip
  azure-cli
).each do |p|
  describe package(p) do
    it { should be_installed }
  end
end

describe command('jq') do
  it { should exist }
end