import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';

part 'state.g.dart';

class State extends EnumClass {
  static const State ac = _$ac;
  static const State al = _$al;
  static const State ap = _$ap;
  static const State am = _$am;
  static const State ba = _$ba;
  static const State ce = _$ce;
  static const State df = _$df;
  static const State es = _$es;
  static const State go = _$go;
  static const State ma = _$ma;
  static const State mg = _$mg;
  static const State ms = _$ms;
  static const State mt = _$mt;
  static const State pa = _$pa;
  static const State pb = _$pb;
  static const State pe = _$pe;
  static const State pi = _$pi;
  static const State pr = _$pr;
  static const State rj = _$rj;
  static const State rn = _$rn;
  static const State rs = _$rs;
  static const State ro = _$ro;
  static const State rr = _$rr;
  static const State sc = _$sc;
  static const State sp = _$sp;
  static const State se = _$se;
  static const State to = _$to;

  const State._(String name) : super(name);

  static BuiltSet<State> get values => _$values;
  static State valueOf(String name) =>
    name == null
      ? null
      : _$valueOf(name?.toLowerCase());
}