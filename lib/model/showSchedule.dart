import 'package:flutter/material.dart';

class ShowSchedule {
  final int _id;
  int _pub_id;
  int _band_id;
  String _show_datetime;
  bool _confirmed;
  String _confirmed_at;
  String _requested_at;
  // dynamic _date;
  // dynamic _time;

  ShowSchedule(
      {int id,
      @required int pub_id,
      @required int band_id,
      @required String show_datetime,
      bool confirmed,
      String confirmed_at,
      String requested_at})
      : _id = id,
        _pub_id = pub_id,
        _band_id = band_id,
        _show_datetime = show_datetime,
        _confirmed = confirmed,
        _confirmed_at = confirmed_at,
        _requested_at = requested_at;

  ShowSchedule copyWith({
    int id,
    int pub_id,
    int band_id,
    String show_datetime,
    bool confirmed,
    String confirmed_at,
    String requested_at,
  }) {
    return ShowSchedule(
      id: id ?? this._id,
      pub_id: pub_id ?? this._pub_id,
      band_id: band_id ?? this._band_id,
      show_datetime: show_datetime ?? this._show_datetime,
      confirmed: confirmed ?? this._confirmed,
      confirmed_at: confirmed_at ?? this._confirmed_at,
      requested_at: requested_at ?? this._requested_at,
    );
  }

  ShowSchedule.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _pub_id = json['pub_id'],
        _band_id = json['band_id'],
        _show_datetime = json['show_datetime'],
        _confirmed = json['confirmed'],
        _confirmed_at = json['confirmed_at'],
        _requested_at = json['requested_at'];

  Map<String, dynamic> toJson() => {
        'id': _id,
        'pub_id': _pub_id,
        'band_id': _band_id,
        'show_datetime': _show_datetime,
        'confirmed': _confirmed,
        'confirmed_at': _confirmed_at,
        'requested_at': _requested_at
      };

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': _id,
  //     'pub_id': _pub_id,
  //     'band_id': _band_id,
  //     'show_datetime': _show_datetime,
  //     'confirmed': _confirmed,
  //     'confirmed_at': _confirmed_at,
  //     'requested_at': _requested_at,
  //   };
  // }

  // factory ShowSchedule.fromMap(Map<String, dynamic> map) {
  //   if (map == null) return null;

  //   return ShowSchedule(
  //     id: map['id'],
  //     pub_id: map['pub_id'],
  //     band_id: map['band_id'],
  //     show_datetime: map['show_datetime'],
  //     confirmed: map['confirmed'],
  //     confirmed_at: map['confirmed_at'],
  //     requested_at: map['requested_at'],
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory ShowSchedule.fromJson(String source) =>
  //     ShowSchedule.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'ShowSchedule(id: $_id, pub_id: $_pub_id, band_id: $_band_id, show_datetime: $_show_datetime, confirmed: $_confirmed, confirmed_at: $_confirmed_at, requested_at: $_requested_at)';
  // }

  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is ShowSchedule &&
  //       o._id == _id &&
  //       o._pub_id == _pub_id &&
  //       o._band_id == _band_id &&
  //       o._show_datetime == _show_datetime &&
  //       o._confirmed == _confirmed &&
  //       o._confirmed_at == _confirmed_at &&
  //       o._requested_at == _requested_at;
  // }

  // @override
  // int get hashCode {
  //   return _id.hashCode ^
  //       _pub_id.hashCode ^
  //       _band_id.hashCode ^
  //       _show_datetime.hashCode ^
  //       _confirmed.hashCode ^
  //       _confirmed_at.hashCode ^
  //       _requested_at.hashCode;
  // }
}
