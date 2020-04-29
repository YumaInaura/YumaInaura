# $ FOO=foo BAR=bar rspec example_spec.rb

require "pry"

RSpec.describe do
  # OK
  describe do
    it { expect(ENV['FOO']).to eq 'foo' }
    it { expect(ENV['BAR']).to eq 'bar' }
  end

  # OK
  describe do
    it { expect(ENV.fetch('FOO')).to eq 'foo' }
    it { expect(ENV.fetch('BAR')).to eq 'bar' }
  end

  # OK
  # Mock hash
  describe do
    before do
      allow(ENV).to receive(:[]).and_call_original # necessarry
      allow(ENV).to receive(:[]).with('FOO').and_return('mocked foo')
    end

    it { expect(ENV['FOO']).to eq 'mocked foo' }
    it { expect(ENV['BAR']).to eq 'bar' }
  end


  # OK
  # mock fetch method
  describe do
    before do
      allow(ENV).to receive(:fetch).and_call_original
      allow(ENV).to receive(:fetch).with('FOO').and_return('mocked foo')
    end

    it { expect(ENV.fetch('FOO')).to eq 'mocked foo' }
    it { expect(ENV.fetch('BAR')).to eq 'bar' }
  end

  # OK
  # Overwrite ENV and return after
  describe do
    before do
      @foo = ENV['FOO']
      ENV['FOO'] = 'mocked foo'
    end

    after do
      ENV['FOO'] = @foo
    end

    it { expect(ENV['FOO']).to eq 'mocked foo' }
    it { expect(ENV['BAR']).to eq 'bar' }
    it { expect(ENV.fetch('FOO')).to eq 'mocked foo' }
    it { expect(ENV.fetch('BAR')).to eq 'bar' }
  end


  # NG
  # Mock hash
  # Failure/Error: it { expect(ENV["BAR"]).to eq "bar" }

  # {"RBENV_VERSION"=>"2.5.7", "TERM_PROGRAM"=>"iTerm.app"...} received :[] with unexpected arguments
  #   expected: ("FOO")
  #        got: ("BAR")
  #  Please stub a default value first if message might be received with other args as well.
  describe do
    before do
      # allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("FOO").and_return("mocked foo")
    end
    it { expect(ENV["FOO"]).to eq "mocked foo" }
    it { expect(ENV["BAR"]).to eq "bar" }
  end


  # NG
  # Mock hash
  #
  #   Failure/Error: it { expect(ENV.fetch("BAR")).to eq "bar" }
  #
  # {"RBENV_VERSION"=>"2.7.0", "TERM_PROGRAM"=>"iTerm.app", ... received :fetch with unexpected arguments
  # expected: ("FOO")
  #      got: ("BAR")

  describe do
    before do
      # allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:fetch).with("FOO").and_return("mocked foo")
    end

    it do

      binding.pry

    end

    it { expect(ENV.fetch("FOO")).to eq "mocked foo" }
    it { expect(ENV.fetch("BAR")).to eq "bar" }
  end

  # NG in two cases
  # not return ENV after
  describe do
    before do
      ENV['FOO'] = 'mocked foo'
    end

    it { expect(ENV['FOO']).to eq 'mocked foo' }
  end
  # Still Mocked env
  describe do
    it { expect(ENV['FOO']).to eq 'foo' }
  end

end


# Result example
#
# is expected to eq "foo"
# is expected to eq "bar"

# is expected to eq "foo"
# is expected to eq "bar"

# is expected to eq "mocked foo"
# is expected to eq "bar"

# is expected to eq "mocked foo"
# is expected to eq "bar"

# is expected to eq "mocked foo"
# is expected to eq "bar"
# is expected to eq "mocked foo"
# is expected to eq "bar"

# is expected to eq "mocked foo"
# example at /Users/yumainaura/tmp/env-mock-spec.rb:77 (FAILED - 1)

# is expected to eq "mocked foo"

# is expected to eq "foo" (FAILED - 2)
