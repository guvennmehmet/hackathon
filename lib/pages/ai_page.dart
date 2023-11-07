import 'package:flutter/material.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  var subjectSelectedCard = -1;
  var timeSelectedCard = -1;
  var lengthSelectedCard = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yapay Zeka"),
      ),
      body: Column(
        children: [
          const Text(
            "Konu Seçiniz",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              itemCount: subjectList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: (subjectSelectedCard == index) ? Colors.blue : Colors
                          .white,
                      width: 2.0,
                    ),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        subjectSelectedCard = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 120,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://picsum.photos/id/237/200/300",
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              subjectList[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Text(
            "Zaman Seçiniz",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 180,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              itemCount: timeList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: (timeSelectedCard == index) ? Colors.blue : Colors
                          .white,
                      width: 2.0,
                    ),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        timeSelectedCard = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 120,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              "https://picsum.photos/id/237/200/300",
                              width: 100,
                              height: 100,
                            ),
                            Text(
                              timeList[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Text(
            "Uzunluk Seçiniz",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 70,
            child: ListView.separated(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              itemCount: lengthList.length,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: (lengthSelectedCard == index) ? Colors.blue : Colors
                          .white,
                      width: 2.0,
                    ),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        lengthSelectedCard = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      width: 120,
                      child: Center(
                        child: Text(
                              lengthList[index],
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: (subjectSelectedCard != -1 && timeSelectedCard != -1 && lengthSelectedCard != -1)
                ? () {
              Navigator.pushNamed(context, '/ai-story-detail', arguments: {
                "subject": subjectList[subjectSelectedCard],
                "time": timeList[timeSelectedCard],
                "length": lengthInts[lengthSelectedCard],
              });
            }
                : null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
              minimumSize: const Size(200, 50),
              elevation: 5,
            ),
            child: const Text("Başla")
          )
        ]
        ,
      )
      ,
    );
  }
}

List<String> subjectList = [
  "Aşk",
  "Bilim Kurgu",
  "Fantastik",
  "Korku",
  "Dram",
  "Macera",
  "Gerilim",
  "Komedi"
];

List<String> timeList = [
  "İlk Çağ",
  "Orta Çağ",
  "Rönesans",
  "1700'ler",
  "1800'ler",
  "1900'ler",
  "Günümüz",
  "2100'ler",
  "3000'ler"
];

List<String> lengthList = [
  "Kısa",
  "Orta",
  "Uzun"
];

List<int> lengthInts = [
  1000,
  2000,
  3000
];
