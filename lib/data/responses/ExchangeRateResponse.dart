import 'package:json_annotation/json_annotation.dart';

part 'ExchangeRateResponse.g.dart';

@JsonSerializable(nullable: false)
class ExchangeRateResponse {
  String time;

  @JsonKey(name: 'asset_id_base')
  String fromCurrency;

  @JsonKey(name: 'asset_id_quote')
  String toCurrency;
  double rate;

  factory ExchangeRateResponse.fromJson(Map<String, dynamic> json) =>
      _$ExchangeRateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExchangeRateResponseToJson(this);

  ExchangeRateResponse(
      this.time, this.fromCurrency, this.toCurrency, this.rate);
}
