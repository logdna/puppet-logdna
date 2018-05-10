require 'serverspec'

set :backend, :exec

describe package('logdna-agent') do
  it { should be_installed }
end
