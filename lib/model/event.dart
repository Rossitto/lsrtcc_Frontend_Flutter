import 'dart:convert';
import 'package:lsrtcc_flutter/model/band.dart';
import 'package:lsrtcc_flutter/model/pub.dart';

// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

List<Event> eventFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  Event({
    this.id,
    this.pub,
    this.band,
    this.showDatetime,
    this.confirmed,
    this.confirmedAt,
    this.requestedAt,
    this.requestedByBand,
  });

  int id;
  Pub pub;
  Band band;
  DateTime showDatetime;
  bool confirmed;
  DateTime confirmedAt;
  DateTime requestedAt;
  bool requestedByBand;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        pub: Pub.fromJson(json["pub"]),
        band: Band.fromJson(json["band"]),
        showDatetime: json["show_datetime"] == null
            ? null
            : DateTime.parse(json["show_datetime"]),
        confirmed: json["confirmed"],
        confirmedAt: json["confirmed_at"] == null
            ? null
            : DateTime.parse(json["confirmed_at"]),
        requestedAt: json["requested_at"] == null
            ? null
            : DateTime.parse(json["requested_at"]),
        requestedByBand: json["requested_by_band"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pub": pub.toJson(),
        "band": band.toJson(),
        "show_datetime":
            showDatetime == null ? null : showDatetime.toIso8601String(),
        "confirmed": confirmed,
        "confirmed_at":
            confirmedAt == null ? null : confirmedAt.toIso8601String(),
        "requested_at":
            requestedAt == null ? null : requestedAt.toIso8601String(),
        "requested_by_band": requestedByBand,
      };
}


// OLD: 27jul2021 commented out

// import 'package:flutter/material.dart';

// class Event {
//   final int _id;
//   int _pub_id;
//   int _band_id;
//   String _show_datetime;
//   bool _confirmed;
//   String _confirmed_at;
//   String _requested_at;
//   // dynamic _date;
//   // dynamic _time;

//   Event(
//       {int id,
//       @required int pub_id,
//       @required int band_id,
//       @required String show_datetime,
//       bool confirmed,
//       String confirmed_at,
//       String requested_at})
//       : _id = id,
//         _pub_id = pub_id,
//         _band_id = band_id,
//         _show_datetime = show_datetime,
//         _confirmed = confirmed,
//         _confirmed_at = confirmed_at,
//         _requested_at = requested_at;

//   Event copyWith({
//     int id,
//     int pub_id,
//     int band_id,
//     String show_datetime,
//     bool confirmed,
//     String confirmed_at,
//     String requested_at,
//   }) {
//     return Event(
//       id: id ?? this._id,
//       pub_id: pub_id ?? this._pub_id,
//       band_id: band_id ?? this._band_id,
//       show_datetime: show_datetime ?? this._show_datetime,
//       confirmed: confirmed ?? this._confirmed,
//       confirmed_at: confirmed_at ?? this._confirmed_at,
//       requested_at: requested_at ?? this._requested_at,
//     );
//   }

//   Event.fromJson(Map<String, dynamic> json)
//       : _id = json['id'],
//         _pub_id = json['pub_id'],
//         _band_id = json['band_id'],
//         _show_datetime = json['show_datetime'],
//         _confirmed = json['confirmed'],
//         _confirmed_at = json['confirmed_at'],
//         _requested_at = json['requested_at'];

//   Map<String, dynamic> toJson() => {
//         'id': _id,
//         'pub_id': _pub_id,
//         'band_id': _band_id,
//         'show_datetime': _show_datetime,
//         'confirmed': _confirmed,
//         'confirmed_at': _confirmed_at,
//         'requested_at': _requested_at
//       };

//   // Map<String, dynamic> toMap() {
//   //   return {
//   //     'id': _id,
//   //     'pub_id': _pub_id,
//   //     'band_id': _band_id,
//   //     'show_datetime': _show_datetime,
//   //     'confirmed': _confirmed,
//   //     'confirmed_at': _confirmed_at,
//   //     'requested_at': _requested_at,
//   //   };
//   // }

//   // factory Event.fromMap(Map<String, dynamic> map) {
//   //   if (map == null) return null;

//   //   return Event(
//   //     id: map['id'],
//   //     pub_id: map['pub_id'],
//   //     band_id: map['band_id'],
//   //     show_datetime: map['show_datetime'],
//   //     confirmed: map['confirmed'],
//   //     confirmed_at: map['confirmed_at'],
//   //     requested_at: map['requested_at'],
//   //   );
//   // }

//   // String toJson() => json.encode(toMap());

//   // factory Event.fromJson(String source) =>
//   //     Event.fromMap(json.decode(source));

//   // @override
//   // String toString() {
//   //   return 'Event(id: $_id, pub_id: $_pub_id, band_id: $_band_id, show_datetime: $_show_datetime, confirmed: $_confirmed, confirmed_at: $_confirmed_at, requested_at: $_requested_at)';
//   // }

//   // @override
//   // bool operator ==(Object o) {
//   //   if (identical(this, o)) return true;

//   //   return o is Event &&
//   //       o._id == _id &&
//   //       o._pub_id == _pub_id &&
//   //       o._band_id == _band_id &&
//   //       o._show_datetime == _show_datetime &&
//   //       o._confirmed == _confirmed &&
//   //       o._confirmed_at == _confirmed_at &&
//   //       o._requested_at == _requested_at;
//   // }

//   // @override
//   // int get hashCode {
//   //   return _id.hashCode ^
//   //       _pub_id.hashCode ^
//   //       _band_id.hashCode ^
//   //       _show_datetime.hashCode ^
//   //       _confirmed.hashCode ^
//   //       _confirmed_at.hashCode ^
//   //       _requested_at.hashCode;
//   // }
// }
