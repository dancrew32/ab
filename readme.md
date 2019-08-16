# A/B Testing for Python

Without the need for a database, deterministically bucket users into A/B tests.

## Build Status:

[![Build Status](https://travis-ci.org/dancrew32/ab.svg?branch=master)](https://travis-ci.org/dancrew32/ab)

## Install:

```
pip install ab
```

Thanks to Delvian for graciously donating the pip module name at https://pypi.org/project/ab/!

## Example A/B Usage:

```python
from ab import ab

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

Thanks to Alexander Ejbekov for the allocation technique:

https://stackoverflow.com/a/23846715/61410


## Example Multi-Armed Bandit Usage:

https://en.wikipedia.org/wiki/Multi-armed_bandit

If you don't already have redis installed & running:

```bash
make redis_install redis_start
```

You may want to adjust environment variables to match your redis configuration.

```bash
export AB_HOST=localhost
export AB_PORT=6379
export AB_DB=0
```


```python
from ab import mab

# Define test & buckets
TEST_NAME = 'MY_TEST_V2'
TEST_CONTROL = 'control'
TEST_VARIANT1 = 'variant1'
TEST_VARIANT2 = 'variant2'
TEST_BUCKETS = (
    TEST_CONTROL,
    TEST_VARIANT1,
    TEST_VARIANT2,
)


# Implemention
def get_button_color():
    bucket = mab.get_bucket(test=TEST_NAME, buckets=TEST_BUCKETS)
    if bucket == TEST_CONTROL:
        return ('green', bucket)
    if bucket == TEST_VARIANT1:
        return ('red', bucket)
    if bucket == TEST_VARIANT2:
        return ('blue', bucket)
    raise mab.MABTestError(f'Unexpected bucket {bucket}')


# Record success
def button_clicked(bucket):
    mab.success(test=TEST_NAME, bucket=bucket)
```

## Development

Ensure you have python3 and virtualenv installed:

```
sudo apt install python3.7 python3-venv python3.7-venv
```

Then make the virtualenv, install any dependencies (there aren't any at the moment), and run the unit tests.

```bash
make venv deps test
```

## Publish new version to PyPI

```
make setup
```
