test_name 'Ruby can load libfacter'

agents.each do |agent|
  if agent.platform.variant == 'windows'
    facter_loader = 'C:/Program Files/Puppet Labs/Puppet/facter/lib/facter.rb'
    path = '/cygdrive/c/Windows/system32:/cygdrive/c/Windows'
  else
    facter_loader = '/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/facter.rb'
    path = '/usr/local/bin:/bin:/usr/bin'
  end

  # Ensure privatebindir comes first so we get the correct Ruby version.
  on agent, "env PATH='#{agent['privatebindir']}:#{path}' ruby '#{facter_loader}'" do
    assert_empty stdout
    assert_empty stderr
  end
end
