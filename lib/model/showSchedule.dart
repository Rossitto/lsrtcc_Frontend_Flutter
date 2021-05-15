import 'dart:convert';

import 'package:flutter/material.dart';

class ShowSchedule {
  final int _id;
  int _pubId;
  int _bandId;
  // dynamic _date;
  // dynamic _time;
  DateTime _show_datetime;
  bool _confirmed;
  DateTime _confirmed_at;
  DateTime _requested_at;

  ShowSchedule(
      {int id,
      @required int pubId,
      @required int bandId,
      @required DateTime show_datetime,
      bool confirmed,
      DateTime confirmed_at,
      DateTime requested_at})
      : _id = id,
        _pubId = pubId,
        _bandId = bandId,
        _show_datetime = show_datetime,
        _confirmed = confirmed,
        _confirmed_at = confirmed_at,
        _requested_at = requested_at;

  ShowSchedule copyWith({
    int id,
    int pubId,
    int bandId,
    DateTime show_datetime,
    bool confirmed,
    DateTime confirmed_at,
    DateTime requested_at,
  }) {
    return ShowSchedule(
      id: id ?? this._id,
      pubId: pubId ?? this._pubId,
      bandId: bandId ?? this._bandId,
      show_datetime: show_datetime ?? this._show_datetime,
      confirmed: confirmed ?? this._confirmed,
      confirmed_at: confirmed_at ?? this._confirmed_at,
      requested_at: requested_at ?? this._requested_at,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'pub_id': _pubId,
      'band_id': _bandId,
      'show_datetime': _show_datetime,
      'confirmed': _confirmed,
      'confirmed_at': _confirmed_at,
      'requested_at': _requested_at,
    };
  }

  factory ShowSchedule.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ShowSchedule(
      id: map['id'],
      pubId: map['pub_id'],
      bandId: map['band_id'],
      show_datetime: map['show_datetime'],
      confirmed: map['confirmed'],
      confirmed_at: map['confirmed_at'],
      requested_at: map['requested_at'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowSchedule.fromJson(String source) =>
      ShowSchedule.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ShowSchedule(id: $_id, pub_id: $_pubId, band_id: $_bandId, show_datetime: $_show_datetime, confirmed: $_confirmed, confirmed_at: $_confirmed_at, requested_at: $_requested_at)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ShowSchedule &&
        o._id == _id &&
        o._pubId == _pubId &&
        o._bandId == _bandId &&
        o._show_datetime == _show_datetime &&
        o._confirmed == _confirmed &&
        o._confirmed_at == _confirmed_at &&
        o._requested_at == _requested_at;
  }

  @override
  int get hashCode {
    return _id.hashCode ^
        _pubId.hashCode ^
        _bandId.hashCode ^
        _show_datetime.hashCode ^
        _confirmed.hashCode ^
        _confirmed_at.hashCode ^
        _requested_at.hashCode;
  }
}
