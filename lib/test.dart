// Specify the path to the data.txt file
import 'dart:io';

const filePath = 'test.txt';
List<String> data1 = [];
List<String> data2 = [];
List<String> data3 = [];
List<String> data4 = [];
void main() {
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
    // print(data3);
  } catch (e) {
    print('An error occurred: $e');
  }

  for (int k = 0; k < data1.length; k++) {
    returnValue(data1[k], data2[k]);
    returnValue(data2[k], data1[k]);
    returnValue(data1[k], data3[k]);
    returnValue(data3[k], data1[k]);
    returnValue(data2[k], data3[k]);
    returnValue(data3[k], data2[k]);
  }
}

int returnValue(String s, String t) {
  int cnt = 0;

  // 1, 2 감독
  for (int j = 0; j < data1.length; j++) {
    if (data1[j] == s && data2[j] == t) {
      cnt++;
    }
  }
  // 1, 3 감독
  for (int j = 0; j < data1.length; j++) {
    if (data3[j] != '') {
      if (data1[j] == s && data3[j] == t) {
        cnt++;
      }
    }
  }
  // 2,3 감독
  for (int j = 0; j < data1.length; j++) {
    if (data3[j] != '') {
      if (data2[j] == s && data3[j] == t) {
        cnt++;
      }
    }
  }
  if (cnt > 1) {
    print(' $s 와 $t, count: $cnt 번');
  }
  return cnt;
}
