import 'dart:convert';

class CreditCard {
  String token;
  String cvv;
  DateTime expiresOn;

  CreditCard({
    this.token,
    this.cvv,
    this.expiresOn,
  });

  CreditCard copyWith({
    String token,
    String cvv,
    DateTime expiresOn,
  }) {
    return CreditCard(
      token: token ?? this.token,
      cvv: cvv ?? this.cvv,
      expiresOn: expiresOn ?? this.expiresOn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'cvv': cvv,
      'expiresOn': expiresOn?.toString(),
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CreditCard(
      token: map['token'],
      cvv: map['cvv'],
      expiresOn: DateTime.tryParse(map['expiresOn'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCard.fromJson(String source) => 
    CreditCard.fromMap(
      source == null
        ? null
        : json.decode(source)
    );

  @override
  String toString() => 'CreditCard(token: $token, cvv: $cvv, expiresOn: $expiresOn)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CreditCard &&
      o.token == token &&
      o.cvv == cvv &&
      o.expiresOn == expiresOn;
  }

  @override
  int get hashCode => token.hashCode ^ cvv.hashCode ^ expiresOn.hashCode;
}
