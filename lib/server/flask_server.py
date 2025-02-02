from flask import Flask, request, jsonify
import nbformat
from nbconvert.preprocessors import ExecutePreprocessor
import subprocess
import os

app = Flask(__name__)

@app.route('/run_notebook', methods=['POST'])
def run_notebook():
    data = request.get_json()
    notebook_path = data['notebook_path']
    with open(notebook_path) as f:
        nb = nbformat.read(f, as_version=4)
    ep = ExecutePreprocessor(timeout=600, kernel_name='python3')
    ep.preprocess(nb, {'metadata': {'path': './'}})
    with open(notebook_path, 'w') as f:
        nbformat.write(nb, f)
    return jsonify({"message": "Notebook executed successfully"})

@app.route('/view_notebook', methods=['GET'])
def view_notebook():
    notebook_path = request.args.get('notebook_path')
    with open(notebook_path) as f:
        nb = nbformat.read(f, as_version=4)
    return jsonify(nb)

@app.route('/add_pip_library', methods=['POST'])
def add_pip_library():
    data = request.get_json()
    library_name = data['library_name']
    result = subprocess.run(['pip', 'install', library_name], capture_output=True, text=True)
    if result.returncode != 0:
        return jsonify({"error": result.stderr}), 400
    return jsonify({"message": "Library installed successfully"})

if __name__ == '__main__':
    app.run(debug=True)
