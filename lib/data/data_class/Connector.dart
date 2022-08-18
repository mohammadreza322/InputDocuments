class Connector {
    int connectorId;
    String connectorType;
    String name;
    bool status;

    Connector({required this.connectorId, required this.connectorType, required this.name, required this.status});

    factory Connector.fromJson(Map<String, dynamic> json) {
        return Connector(
            connectorId: json['connectorId'], 
            connectorType: json['connectorType'], 
            name: json['name'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['connectorId'] = this.connectorId;
        data['connectorType'] = this.connectorType;
        data['name'] = this.name;
        data['status'] = this.status;
        return data;
    }
}