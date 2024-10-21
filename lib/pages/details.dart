import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({super.key, this.detail});
  @required
  final detail;
  @override
  State<Details> createState() => _DetailsState();
}

var plate = {
  "new": "Yangi",
  "in_progress": "Jarayonda",
  "in_review": "Ko'rib chiqilmoqda",
  "done": "Bajarildi"
};

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("№${widget.detail['task_id']} topshiriq haqaida"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Card(
                  color: Colors.green.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 45,
                        foregroundImage: NetworkImage(
                            widget.detail['owner_avatar'].toString()),
                      ),
                      const VerticalDivider(),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Loyiha nomi: ${widget.detail['project_name']}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            'Buyurtmachi: ${widget.detail['owner_name']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.60,
                            child: Text(
                              "Bajarilishi kerak: ${widget.detail['name']}",
                              maxLines: 10,
                              textAlign: TextAlign.left,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            'Berilgan vaqti: ${widget.detail['task_date']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Tugash vaqti: ${widget.detail['term_date']}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Holati: ${plate[widget.detail['status']]}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Ijrochi:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                  radius: 25,
                                  foregroundImage: NetworkImage(
                                      widget.detail['executor_avatar'])),
                              const VerticalDivider(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'F.I.Sh: ' + widget.detail['executor_name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Ijrochi IDsi: ${widget.detail['executor_id']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
