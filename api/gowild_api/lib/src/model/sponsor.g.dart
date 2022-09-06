// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sponsor.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Sponsor extends Sponsor {
  @override
  final String treasureChestId;
  @override
  final String imgUrl;
  @override
  final JsonObject img;
  @override
  final String link;

  factory _$Sponsor([void Function(SponsorBuilder)? updates]) =>
      (new SponsorBuilder()..update(updates))._build();

  _$Sponsor._(
      {required this.treasureChestId,
      required this.imgUrl,
      required this.img,
      required this.link})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        treasureChestId, r'Sponsor', 'treasureChestId');
    BuiltValueNullFieldError.checkNotNull(imgUrl, r'Sponsor', 'imgUrl');
    BuiltValueNullFieldError.checkNotNull(img, r'Sponsor', 'img');
    BuiltValueNullFieldError.checkNotNull(link, r'Sponsor', 'link');
  }

  @override
  Sponsor rebuild(void Function(SponsorBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SponsorBuilder toBuilder() => new SponsorBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Sponsor &&
        treasureChestId == other.treasureChestId &&
        imgUrl == other.imgUrl &&
        img == other.img &&
        link == other.link;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, treasureChestId.hashCode), imgUrl.hashCode),
            img.hashCode),
        link.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Sponsor')
          ..add('treasureChestId', treasureChestId)
          ..add('imgUrl', imgUrl)
          ..add('img', img)
          ..add('link', link))
        .toString();
  }
}

class SponsorBuilder implements Builder<Sponsor, SponsorBuilder> {
  _$Sponsor? _$v;

  String? _treasureChestId;
  String? get treasureChestId => _$this._treasureChestId;
  set treasureChestId(String? treasureChestId) =>
      _$this._treasureChestId = treasureChestId;

  String? _imgUrl;
  String? get imgUrl => _$this._imgUrl;
  set imgUrl(String? imgUrl) => _$this._imgUrl = imgUrl;

  JsonObject? _img;
  JsonObject? get img => _$this._img;
  set img(JsonObject? img) => _$this._img = img;

  String? _link;
  String? get link => _$this._link;
  set link(String? link) => _$this._link = link;

  SponsorBuilder() {
    Sponsor._defaults(this);
  }

  SponsorBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _treasureChestId = $v.treasureChestId;
      _imgUrl = $v.imgUrl;
      _img = $v.img;
      _link = $v.link;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Sponsor other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Sponsor;
  }

  @override
  void update(void Function(SponsorBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Sponsor build() => _build();

  _$Sponsor _build() {
    final _$result = _$v ??
        new _$Sponsor._(
            treasureChestId: BuiltValueNullFieldError.checkNotNull(
                treasureChestId, r'Sponsor', 'treasureChestId'),
            imgUrl: BuiltValueNullFieldError.checkNotNull(
                imgUrl, r'Sponsor', 'imgUrl'),
            img: BuiltValueNullFieldError.checkNotNull(img, r'Sponsor', 'img'),
            link: BuiltValueNullFieldError.checkNotNull(
                link, r'Sponsor', 'link'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
