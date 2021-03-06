# https://relishapp.com/rspec/rspec-core/v/3-8/docs/helper-methods/arbitrary-helper-methods
#
# Arbitrary helper methods
#
# You can define methods in any example group using Ruby's def keyword or
# define_method method. These helper methods are exposed to examples in the
# group in which they are defined and groups nested within that group, but not
# parent or sibling groups.

# PASS
RSpec.describe "flat define method" do
  def help
    :available
  end

  it do
    expect(help).to be(:available)
  end
end

# PASS
RSpec.describe "define method and use in child describe" do
  def help
    :available
  end

  describe do
    it do
      expect(help).to be(:available)
    end
  end
end

# ERROR
RSpec.describe "define method chuld describe and use it in parent describe" do
  describe do
    def help
      :available
    end
  end

  # NameError:
  # undefined local variable or method `help' for #<RSpec::ExampleGroups::AnExample_3:0x00007f95d5a6c9e0>
  it do
    expect(help).to be(:available)
  end
end

# ERROR
RSpec.describe "not defined method in describe" do
  # has access to methods defined in its group (FAILED - 1)
  it do
    expect(help).to be(:available)
  end
end

# PASS
# OTHER USAGE
RSpec.describe "expectation in helper" do
  def expect_true_is_true
    expect(true).to eq true
  end

  it do
    expect_true_is_true
  end
end

# $ rspec /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/def-helper-method.rb

# flat define method
#   is expected to equal :available

# define method and use in child describe

#     is expected to equal :available

# define method chuld describe and use it in parent describe
#   example at /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/def-helper-method.rb:44 (FAILED - 1)

# not defined method in describe
#   example at /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/def-helper-method.rb:52 (FAILED - 2)

# expectation in helper
#   is expected to eq true

# Failures:

#   1) define method chuld describe and use it in parent describe
#      Failure/Error: expect(help).to be(:available)

#      NameError:
#        undefined local variable or method `help' for #<RSpec::ExampleGroups::DefineMethodChuldDescribeAndUseItInParentDescribe:0x00007fd91e12d230>
#      # /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/def-helper-method.rb:45:in `block (2 levels) in <top (required)>'

#   2) not defined method in describe
#      Failure/Error: expect(help).to be(:available)

#      NameError:
#        undefined local variable or method `help' for #<RSpec::ExampleGroups::NotDefinedMethodInDescribe:0x00007fd91e17e518>
#      # /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/def-helper-method.rb:53:in `block (2 levels) in <top (required)>'

# Finished in 0.00882 seconds (files took 0.16091 seconds to load)
# 5 examples, 2 failures

# Failed examples:

# rspec /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/def-helper-method.rb:44 # define method chuld describe and use it in parent describe
# rspec /Users/yumainaura/.ghq/github.com/YumaInaura/YumaInaura/rspec/def-helper-method.rb:52 # not defined method in describe
