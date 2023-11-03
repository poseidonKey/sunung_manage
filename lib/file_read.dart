import 'dart:io';

void main() {
  // Specify the path to the data.txt file
  const filePath = 'test.txt';
  List<String> data1 = [];
  List<String> data2 = [];
  List<String> data3 = [];
  List<String> data4 = [];

  try {
    // Read the contents of the file
    final file = File(filePath);
    final contents = file.readAsStringSync();

    // Split the content by the comma delimiter
    final values = contents.split(',');

    // Print the resulting array
    // print(values);
    for (int i = 0; i < values.length; i++) {
      if (i % 4 == 1) {
        data1.add(values[i]);
      }
      if (i % 4 == 2) {
        data2.add(values[i]);
      }
      if (i % 4 == 3) {
        data3.add(values[i]);
      }
      if (i % 4 == 0) {
        data4.add(values[i]);
      }
    }
    print(data3);
  } catch (e) {
    print('An error occurred: $e');
  }
}
