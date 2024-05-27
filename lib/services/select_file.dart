import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SelectFilePage extends StatefulWidget {
  @override
  _SelectFilePageState createState() => _SelectFilePageState();
}

class _SelectFilePageState extends State<SelectFilePage> {
  late Directory _directory;
  List<String> _fileNames = [];

  @override
  void initState() {
    super.initState();
    _getDirectoryContents();
  }

  Future<void> _getDirectoryContents() async {
    Directory directory = await getApplicationDocumentsDirectory();
    setState(() {
      _directory = directory;
      _fileNames = _getFilesInDirectory(directory);
    });
  }

  List<String> _getFilesInDirectory(Directory directory) {
    List<FileSystemEntity> files = directory.listSync();
    List<String> fileNames = [];
    for (FileSystemEntity file in files) {
      if (file is File) {
        fileNames.add(file.path.split('/').last);
      }
    }
    return fileNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select File'),
      ),
      body: _directory == null
          ? Center(child: CircularProgressIndicator())
          : _buildFileSelectDropdown(),
    );
  }

  Widget _buildFileSelectDropdown() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: 'Select File'),
        value: null,
        items: _fileNames.map((fileName) {
          return DropdownMenuItem<String>(
            value: fileName,
            child: Text(fileName),
          );
        }).toList(),
        onChanged: (value) {
          // Handle selected file
          print('Selected file: $value');
        },
      ),
    );
  }
}
