import 'dart:convert';

import 'package:flutter/material.dart';

class ShowSchedule {
  final int _id;
  int _pubId;
  int _bandId;
  dynamic _date;
  dynamic _time;

  ShowSchedule(
      {int id,
      @required int pubId,
      @required int bandId,
      @required date,
      @required time})
      : _id = id,
        _pubId = pubId,
        _bandId = bandId,
        _date = date,
        _time = time;

  ShowSchedule copyWith({
    int id,
    int pubId,
    int bandId,
    dynamic date,
    dynamic time,
  }) {
    return ShowSchedule(
      id: id ?? this._id,
      pubId: pubId ?? this._pubId,
      bandId: bandId ?? this._bandId,
      date: date ?? this._date,
      time: time ?? this._time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'pub_id': _pubId,
      'band_id': _bandId,
      'date': _date,
      'time': _time,
    };
  }

  factory ShowSchedule.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ShowSchedule(
      id: map['id'],
      pubId: map['pub_id'],
      bandId: map['band_id'],
      date: map['date'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowSchedule.fromJson(String source) =>
      ShowSchedule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShowSchedule(id: $_id, pub_id: $_pubId, band_id: $_bandId, date: $_date, time: $_time)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ShowSchedule &&
        o._id == _id &&
        o._pubId == _pubId &&
        o._bandId == _bandId &&
        o._date == _date &&
        o._time == _time;
  }

  @override
  int get hashCode {
    return _id.hashCode ^
        _pubId.hashCode ^
        _bandId.hashCode ^
        _date.hashCode ^
        _time.hashCode;
  }
}
