import 'package:date_format/date_format.dart' as DateFormat;
import 'package:flutter/material.dart';

import 'string_util.dart';

class DateFormatUtil {
  static const months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  static const weekdays = [
    'Segunda',
    'Terça',
    'Quarta',
    'Quinta',
    'Sexta',
    'Sábado',
    'Domingo'
  ];

  static String format(DateTime date, List<String> formats) {
    assert(formats != null);
    assert(formats.isNotEmpty);
    assert(date != null);
    
    return DateFormat.formatDate(date, formats);
  }

  static String formatDate(
    DateTime date, 
    {
      bool showDay = true, 
      bool showMonth = true, 
      bool showYear = true
    }
  ) {

    final List<String> formats = [];

    if(showDay) formats.add('dd');

    if(showDay && showMonth || showDay && showYear) formats.add('/');

    if(showMonth) formats.add('mm');

    if(showMonth && showYear) formats.add('/');
    
    if(showYear) formats.add('yyyy');

    return format(date, formats);
  }

  static String formatTime(
    DateTime date, {
      bool showHours = true, 
      bool showMinutes = true, 
      bool showSeconds = false
    }) {

    final formats = <String>[];

    if(showHours) {
      formats.add('HH');
    }

    if(showMinutes) {
      formats.add(':');
      formats.add('nn');
    }

    if(showSeconds) {
      formats.add(':');
      formats.add('ss');
    }

    return format(date, formats);
  }

  static String formatDateTime(
    DateTime date, {
      bool showHours = true, 
      bool showMinutes = true, 
      bool showSeconds = false
    }) {

    return formatDate(date) 
        + ' ' 
        + formatTime(
            date,
            showHours: showHours, 
            showMinutes: showMinutes, 
            showSeconds: showSeconds
          );
  }

  static String getMonthString(int month) {
    assert(month != null);
    assert(month >= 1 || month <= 12);

    return months[month - 1];
  }

  static String getShortMonthString(int month) {
    final shortMonth = getMonthString(month).substring(0, 3);
    return StringUtil.toFirstLetterUpperCase(shortMonth);
  }

  static String getWeekDayString(int weekday) {
    assert(weekday != null);
    assert(weekday > 0 || weekday <= 7);
    return weekdays[weekday - 1];
  }

  static String getNarrowWeekday(DateTime date) {
    assert(date != null);
    final weekday = getWeekDayString(date.weekday);
    return weekday.substring(0, 1).toUpperCase();
  }

  static DateTime mergeDateAndTime(DateTime date, TimeOfDay time) {
    assert(date != null);
    assert(time != null);
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  static int getDaysBetweenDates(DateTime date1, DateTime date2) {
    return date2.difference(date1).inDays;
  }

  static TimeOfDay getTimeOfDayFromDateTime(DateTime dateTime) {
    assert(dateTime != null);
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}