# Partial hash matcher for RSpec

This will match partial, arbitrarily nested hashes:

    {
      'a' => 'foo', 'b' => {
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

In other words, it compares each level of the actual and expected hashes and ensures that the actual hash contains at least the keys and (non-hash) values contained in the expected hash level.
