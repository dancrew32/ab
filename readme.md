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
TEST_BUCKET_TO_COLOR = {
    'control': 'green',
    'variant1': 'red',
    'variant2': 'blue',
}


# Implemention
def get_button_color(user_id):
    buckets = TEST_BUCKET_TO_COLOR.keys()
    bucket = ab.get_bucket(user_id, test=TEST_NAME, buckets=buckets)
		return TEST_BUCKET_TO_COLOR[bucket]
```

Thanks to Alexander Ejbekov for the allocation technique:

https://stackoverflow.com/a/23846715/61410


## Example Multi-Armed Bandit Usage:

https://en.wikipedia.org/wiki/Multi-armed bandit

```python
from ab import mab

# Define test & buckets
TEST_NAME = 'MY_TEST_V2'
TEST_BUCKET_TO_COLOR = {
    'control': 'green',
    'variant1': 'red',
    'variant2': 'blue',
}


# Implemention
def get_button_color():
    buckets = TEST_BUCKET_TO_COLOR.keys()
    bucket = mab.get_bucket(test=TEST_NAME, buckets=buckets)
		return TEST_BUCKET_TO_COLOR[bucket]


# Record success
def button_clicked(bucket):
    mab.success(test=TEST_NAME, bucket=bucket)
```

## Demo MAB app:

```bash
git clone https://github.com/dancrew32/ab.git ab
cd ab
make up
```

Then visit http://localhost:5000

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
