import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const filePath = 'assets/test.txt';

List<String> data1 = [];
List<String> data2 = [];
List<String> data3 = [];
List<String> data4 = [];
List<String> lst = [];
List<int> id = [];
List<List<int>> tmp = [];

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _msg = '행';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('수능 감독관 중복 체크'),
          leading: Text(
            '${lst.length}건',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Text(
                _msg,
                style: const TextStyle(fontSize: 30, color: Colors.amber),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('▶${index + 1} ${lst[index]}'),
                      onTap: () {
                        setState(() {
                          _msg = '행 번호  ${tmp[index].toString()} 확인하세요.';
                        });
                        // print(id[index]);
                      },
                    );
                  },
                  itemCount: lst.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 5,
                      child: Container(
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 5,
                child: Container(
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        lst = [];
                        _msg = '';
                      });
                    },
                    child: const Text('Reset'),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    child: const Text('Search'),
                    onPressed: () async {
                      lst = [];
                      data1 = [];
                      data2 = [];
                      data3 = [];
                      data4 = [];
                      id = [];
                      try {
                        // Read the contents of the file
                        final contents = await rootBundle.loadString(filePath);
                        List<String> rowData = contents.split('\n');
                        // print(rowData[2]);

                        // Split the content by the comma delimiter
                        List<String> imsi;
                        for (int i = 0; i < rowData.length; i++) {
                          id.add(i + 1);
                          imsi = rowData[i].split(',');
                          data4.add(imsi[0]);
                          data1.add(imsi[1]);
                          data2.add(imsi[2]);
                          data3.add(imsi[3]);
                        }
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
                      setState(() {});
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

void returnValue(String s, String t) {
  int cnt = 0;
  Set no = {};
  List<int> selectId = [];

  // 1, 2 감독
  for (int j = 0; j < data1.length; j++) {
    if (data1[j] == s && data2[j] == t) {
      cnt++;
      no.add(data4[j]);
      selectId.add(j + 1);
    }
  }
  // 1, 3 감독
  for (int j = 0; j < data1.length; j++) {
    if (data3[j] != '') {
      if (data1[j] == s && data3[j] == t) {
        cnt++;
        no.add(data4[j]);
        selectId.add(j + 1);
      }
    }
  }
  // 2,3 감독
  for (int j = 0; j < data1.length; j++) {
    if (data3[j] != '') {
      if (data2[j] == s && data3[j] == t) {
        cnt++;
        no.add(data4[j]);
        selectId.add(j + 1);
      }
    }
  }
  if (cnt > 1) {
    var t1 = ' [$s 와 $t], 횟수: $cnt번,  ${no.toList()} 시험실 확인';
    if (!lst.contains(t1)) {
      lst.add(' [$s 와 $t], 횟수: $cnt번,  ${no.toList()} 시험실 확인');
      // print(selectId);
      tmp.add(selectId);
    }
  }
}
