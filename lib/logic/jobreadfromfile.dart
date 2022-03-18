
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class JobReader {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/Job.Teb');
  }

  Future<List<String>> readJob() async {
    try {
      final file = await _localFile;
      final directory = await getApplicationDocumentsDirectory();
      print(directory.path);

      // Read the file
      final contents = await file.readAsString();
      var jobList = <String>[];
      jobList.add("مشاغل");
      jobList= contents.split(",");
      
      return jobList;
    } catch (e) {
      // If encountering an error, return 0
      var jobList = <String>[];
      jobList.add("دیگر");
      return jobList;
    }
  }

}
