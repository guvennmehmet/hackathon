import 'package:flutter/material.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  var subjectSelectedCard = -1;
  var characterSelectedCard = -1;

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
              itemCount: 5,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                return Card(
                  shape: const RoundedRectangleBorder(),
                  color: (subjectSelectedCard == index) ? Colors.blue : Colors
                      .white,
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
            "Karakter Seçiniz",
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
              itemCount: 5,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemBuilder: (context, index) {
                return Card(
                  shape: const RoundedRectangleBorder(),
                  color: (characterSelectedCard == index) ? Colors.blue : Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        characterSelectedCard = index;
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
                              characterList[index],
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
          ElevatedButton(
            onPressed: (subjectSelectedCard != -1 && characterSelectedCard != -1)
                ? () {
              Navigator.pushNamed(context, '/ai-story-detail', arguments: {
                "subject": subjectList[subjectSelectedCard],
                "character": characterList[characterSelectedCard]
              });
            }
                : null,
            child: const Text("Başla"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(200, 50),
              primary: Colors.blue,
              onPrimary: Colors.white,
              elevation: 5,
            )
          )
        ]
        ,
      )
      ,
    );
  }
}

List<String> subjectList = [
  "Hayvanlar",
  "Bitkiler",
  "Meyveler",
  "Renkler",
  "Şekiller",
  "Sayılar",
  "Mutfak",
  "Okul"
];

List<String> characterList = [
  "Ayı",
  "Kedi",
  "Köpek",
  "Aslan",
  "Kuş",
  "Karınca",
  "Kaplumbağa",
  "Eşek"
];
