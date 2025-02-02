import 'dart:io';
import 'package:path_provider/path_provider.dart';

class CpythonWrapper {
  static Future<void> runNotebook(String notebookPath) async {
    final directory = await getApplicationDocumentsDirectory();
    final scriptPath = '${directory.path}/run_notebook.py';

    final scriptContent = '''
import nbformat
from nbconvert.preprocessors import ExecutePreprocessor

def run_notebook(notebook_path):
    with open(notebook_path) as f:
        nb = nbformat.read(f, as_version=4)
    ep = ExecutePreprocessor(timeout=600, kernel_name='python3')
    ep.preprocess(nb, {'metadata': {'path': './'}})
    with open(notebook_path, 'w') as f:
        nbformat.write(nb, f)

run_notebook('$notebookPath')
''';

    final scriptFile = File(scriptPath);
    await scriptFile.writeAsString(scriptContent);

    final result = await Process.run('python3', [scriptPath]);
    if (result.exitCode != 0) {
      throw Exception('Failed to run notebook: ${result.stderr}');
    }
  }

  static Future<void> addPipLibrary(String libraryName) async {
    final result = await Process.run('pip', ['install', libraryName]);
    if (result.exitCode != 0) {
      throw Exception('Failed to install library: ${result.stderr}');
    }
  }
}
