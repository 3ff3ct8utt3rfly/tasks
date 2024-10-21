import 'dart:convert';
import 'package:http/http.dart' as http;
import 'local.dart';

Login(String log, String pas) async {
  var url = Uri.https('rstask.wiremockapi.cloud', 'api/v2/auth/login');
  var resp = await http.post(url,
      headers: {"path": "api/v2/auth/login"},
      body: jsonEncode(
          {"login": log.toString().trim(), "password": pas.toString().trim()}));
  //jsonDecode(resp.body)['token'];

  var url1 = Uri.https('rstask.wiremockapi.cloud', 'api/v1/task/get_all_tasks');
  var resp1 = await http.get(
    url1,
    headers: {"Authorization": "Bearer ${jsonDecode(resp.body)['token']}"},
  );

  await setstring('token', jsonDecode(resp.body)['token'].toString());
  await setstring('tasks', resp1.body);

  await setbul('log', true);
  print(jsonDecode(resp.body)['token']);

  return true;
}

getTask() async {
  var head = await getstring('tasks');

  return jsonDecode(head);
}


// jhonhanks@gmail.com
// aA1234567