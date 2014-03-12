require 'spec_helper'

describe '#include_partial_hash' do

  it 'accepts empty hash' do
    {}.should include_partial_hash({})
  end

  it 'accepts identical hash' do
    {
      'a' => {
        'b' => 42
      }
    }.should include_partial_hash(
      {
        'a' => {
          'b' => 42
        }
      }
    )
  end

  it 'accepts nested hash with some partial matches' do
    {
      'a' => 'foo',
      'b' => {
        'c' => 42,
        'd' => {
          'e' => 'bar'
        }
      }
    }.should include_partial_hash(
      {
        'b' => {
          'd' => {
            'e' => 'bar'
          }
        }
      }
    )
  end

  it 'accepts empty expectation' do
    {
      'a' => 'foo',
      'b' => {
        'c' => 42,
        'd' => {
          'e' => 'bar'
        }
      }
    }.should include_partial_hash(
      {
      }
    )
  end

  it 'accepts simple, non-nestedt hash' do
    {
      'a' => 'foo',
      'b' => {
        'c' => 42,
        'd' => {
          'e' => 'bar'
        }
      }
    }.should include_partial_hash(
      {
        'a' => 'foo'
      }
    )
  end

  it 'rejects nil' do
    {}.should_not include_partial_hash(nil)
  end

  [42, "string", 3.14, ['array']].each do |v|
    it "throws ArgumentError if expectation is a #{v.class.name.downcase}" do
      -> {
        {}.should_not include_partial_hash(v)
      }.should raise_error(ArgumentError)
    end
  end

  it 'rejects non-matching nested hash' do
    {
      'a' => 'foo',
      'b' => {
        'c' => 42
      }
    }.should_not include_partial_hash(
      {
        'c' => {
          'c' => 42
        }
      }
    )
  end

  it 'rejects non-matching nested key' do
    {
      'a' => 'foo',
      'b' => {
        'c' => 42
      }
    }.should_not include_partial_hash(
      {
        'b' => {
          'c' => 41
        }
      }
    )
  end

end