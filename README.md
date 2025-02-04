 create .# Flutter Jupyter Notebook Viewer

This project is a Flutter-based mobile application that allows users to run and view Jupyter Notebook (.ipynb) files. The app includes a Cpython wrapper to run Jupyter notebooks and allows users to add pip libraries. Additionally, the project includes a Flask-based server to load various models of TensorFlow and Torch.

## Features

- View Jupyter Notebook (.ipynb) files
- Run Jupyter notebooks using a Cpython wrapper
- Add pip libraries
- Flask-based server to load TensorFlow and Torch models

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Python: [Install Python](https://www.python.org/downloads/)

### Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/githubnext/workspace-blank.git
   cd workspace-blank
   ```

2. Install Flutter dependencies:
   ```sh
   flutter pub get
   ```

3. Install Python dependencies:
   ```sh
   pip install -r requirements.txt
   ```

### Running the App

1. Connect your mobile device or start an emulator.

2. Run the app:
   ```sh
   flutter run
   ```

### Running the Flask Server

1. Navigate to the server directory:
   ```sh
   cd lib/server
   ```

2. Run the Flask server:
   ```sh
   flask run
   ```

## Usage

1. Open the app on your mobile device.

2. Use the home screen to open and view Jupyter Notebook (.ipynb) files.

3. Add pip libraries as needed.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
