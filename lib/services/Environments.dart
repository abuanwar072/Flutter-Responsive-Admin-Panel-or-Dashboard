import 'dart:collection';

import '../../main.dart';

class Environments
{
  var urls = new HashMap();

  Environments() {
    urls['Production_application'] = "http://192.168.1.180:6000";
  }

  String getHost (String env, String product) {
    if (env == null)
    {
      env = "Development";
    }

    if (env.isEmpty)
    {
      env = "Development";
    }

    return urls[env+"_"+product];
  }


  String get (String env)
  {
    if (env == null)
    {
      env = "Development";
    }

    if (env.isEmpty)
    {
      env = "Development";
    }

    return urls[env];
  }
}