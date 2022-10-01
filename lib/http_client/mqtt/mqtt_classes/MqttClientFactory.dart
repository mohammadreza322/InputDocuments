// ignore_for_file: file_names
///if user connect with web app this file calls `MqttClientFactoryWeb.dart`
///and if user connect with Mobile Application this file calls `MqttClientFactoryServer.dart`
export 'MqttClientFactoryNull.dart'
    if (dart.library.html) 'MqttClientFactoryWeb.dart'
    if (dart.library.io) 'MqttClientFactoryServer.dart';
