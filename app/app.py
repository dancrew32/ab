from flask import Flask, request, redirect, url_for

from ab import mab

app = Flask(__name__)

TEMPLATE = """
<!doctype html>
<html>
<head>
<link rel="icon" type="image/png" href="data:image/png;base64,iVBORw0KGgo=">
</head>
<body>
<pre>
{scores}
</pre>
<form method="POST">
<input type="hidden" name="bucket" value="{bucket}" />
<button type="submit">Mark {bucket} Success</button>
</form>
</body>
</html>
""".strip()


@app.route('/', methods=['GET'])
def home():
    buckets = ('a', 'b', 'c')
    # TODO: run stats.get_results to compute test results!
    scores = mab.get_scores(test='test_name', buckets=buckets)
    bucket = mab.get_bucket(test='test_name', buckets=buckets)
    return TEMPLATE.format(bucket=bucket, scores=scores)


@app.route('/', methods=['POST'])
def success():
    bucket = request.form.get('bucket')
    mab.success(test='test_name', bucket=bucket)
    return redirect(url_for('home'))
