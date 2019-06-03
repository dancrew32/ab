# A/B Testing for Python

Without the need for a database, deterministically bucket users into A/B tests.

## Install

Ensure you have python3 and virtualenv installed:

```
sudo apt install python3.7 python3-venv python3.7-venv
```

Then make the virtualenv, install any dependencies (there aren't any at the moment), and run the unit tests.

```bash
make venv deps test
```

## Example usage:

```python
import ab

# Define test & buckets
TEST_NAME = 'MY_TEST_V1'
TEST_CONTROL = 'control'
TEST_VARIANT1 = 'variant1'
TEST_VARIANT2 = 'variant2'
TEST_BUCKETS = (
    TEST_CONTROL,
    TEST_VARIANT1,
    TEST_VARIANT2,
)

# Implemention
def get_button_color(user_id):
    bucket = ab.get_bucket(user_id, test=TEST_NAME, buckets=TEST_BUCKETS)
    if bucket == TEST_CONTROL:
        return 'green'
    if bucket == TEST_VARIANT1:
        return 'red'
    if bucket == TEST_VARIANT2:
        return 'blue'
    raise ab.ABTestError(f'Unexpected bucket {bucket}')
```

## Credits

Thanks to Alexander Ejbekov for the allocation technique:

https://stackoverflow.com/a/23846715/61410
