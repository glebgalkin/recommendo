// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_local.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RecommendationLocalModel extends _RecommendationLocalModel with RealmEntity, RealmObjectBase, RealmObject {
RecommendationLocalModel(
String id,
String cityId,
String title,
String description,
String img,
int recommendedCount,
{
Iterable<SocialSourceLocal> socialSource = const [],
}
) {
RealmObjectBase.set(this, 'id', id);
RealmObjectBase.set(this, 'cityId', cityId);
RealmObjectBase.set(this, 'title', title);
RealmObjectBase.set(this, 'description', description);
RealmObjectBase.set(this, 'img', img);
RealmObjectBase.set<RealmList<SocialSourceLocal>>(this, 'socialSource', RealmList<SocialSourceLocal>(socialSource));
RealmObjectBase.set(this, 'recommendedCount', recommendedCount);
}

RecommendationLocalModel._();

@override
String get id => RealmObjectBase.get<String>(this, 'id') as String;
@override
set id(String value) => RealmObjectBase.set(this, 'id', value);

@override
String get cityId => RealmObjectBase.get<String>(this, 'cityId') as String;
@override
set cityId(String value) => RealmObjectBase.set(this, 'cityId', value);

@override
String get title => RealmObjectBase.get<String>(this, 'title') as String;
@override
set title(String value) => RealmObjectBase.set(this, 'title', value);

@override
String get description => RealmObjectBase.get<String>(this, 'description') as String;
@override
set description(String value) => RealmObjectBase.set(this, 'description', value);

@override
String get img => RealmObjectBase.get<String>(this, 'img') as String;
@override
set img(String value) => RealmObjectBase.set(this, 'img', value);

@override
RealmList<SocialSourceLocal> get socialSource => RealmObjectBase.get<SocialSourceLocal>(this, 'socialSource') as RealmList<SocialSourceLocal>;
@override
set socialSource(covariant RealmList<SocialSourceLocal> value) => throw RealmUnsupportedSetError();

@override
int get recommendedCount => RealmObjectBase.get<int>(this, 'recommendedCount') as int;
@override
set recommendedCount(int value) => RealmObjectBase.set(this, 'recommendedCount', value);

@override
Stream<RealmObjectChanges<RecommendationLocalModel>> get changes => RealmObjectBase.getChanges<RecommendationLocalModel>(this);

@override
Stream<RealmObjectChanges<RecommendationLocalModel>> changesFor([List<String>? keyPaths]) => RealmObjectBase.getChangesFor<RecommendationLocalModel>(this, keyPaths);

@override
RecommendationLocalModel freeze() => RealmObjectBase.freezeObject<RecommendationLocalModel>(this);

EJsonValue toEJson() {
return <String, dynamic>{
'id': id.toEJson(),
'cityId': cityId.toEJson(),
'title': title.toEJson(),
'description': description.toEJson(),
'img': img.toEJson(),
'socialSource': socialSource.toEJson(),
'recommendedCount': recommendedCount.toEJson(),
};
}
static EJsonValue _toEJson(RecommendationLocalModel value) => value.toEJson();
static RecommendationLocalModel _fromEJson(EJsonValue ejson) {
return switch (ejson) {
{
'id': EJsonValue id,
'cityId': EJsonValue cityId,
'title': EJsonValue title,
'description': EJsonValue description,
'img': EJsonValue img,
'socialSource': EJsonValue socialSource,
'recommendedCount': EJsonValue recommendedCount,
} => RecommendationLocalModel(
fromEJson(id),
fromEJson(cityId),
fromEJson(title),
fromEJson(description),
fromEJson(img),
fromEJson(recommendedCount),
socialSource: fromEJson(socialSource),
),
_ => raiseInvalidEJson(ejson),
};
}
static final schema = () {
RealmObjectBase.registerFactory(RecommendationLocalModel._);
register(_toEJson, _fromEJson);
return SchemaObject(ObjectType.realmObject, RecommendationLocalModel, 'RecommendationLocalModel', [
SchemaProperty('id', RealmPropertyType.string, indexType: RealmIndexType.regular),
SchemaProperty('cityId', RealmPropertyType.string, indexType: RealmIndexType.regular),
SchemaProperty('title', RealmPropertyType.string, indexType: RealmIndexType.fullText),
SchemaProperty('description', RealmPropertyType.string, indexType: RealmIndexType.fullText),
SchemaProperty('img', RealmPropertyType.string),
SchemaProperty('socialSource', RealmPropertyType.object, linkTarget: 'SocialSourceLocal',collectionType: RealmCollectionType.list),
SchemaProperty('recommendedCount', RealmPropertyType.int),
]);
}();

@override
SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
class SocialSourceLocal extends _SocialSourceLocal with RealmEntity, RealmObjectBase, EmbeddedObject {
SocialSourceLocal(
{
String? id,
String? type,
}
) {
RealmObjectBase.set(this, 'id', id);
RealmObjectBase.set(this, 'type', type);
}

SocialSourceLocal._();

@override
String? get id => RealmObjectBase.get<String>(this, 'id') as String?;
@override
set id(String? value) => RealmObjectBase.set(this, 'id', value);

@override
String? get type => RealmObjectBase.get<String>(this, 'type') as String?;
@override
set type(String? value) => RealmObjectBase.set(this, 'type', value);

@override
Stream<RealmObjectChanges<SocialSourceLocal>> get changes => RealmObjectBase.getChanges<SocialSourceLocal>(this);

@override
Stream<RealmObjectChanges<SocialSourceLocal>> changesFor([List<String>? keyPaths]) => RealmObjectBase.getChangesFor<SocialSourceLocal>(this, keyPaths);

@override
SocialSourceLocal freeze() => RealmObjectBase.freezeObject<SocialSourceLocal>(this);

EJsonValue toEJson() {
return <String, dynamic>{
'id': id.toEJson(),
'type': type.toEJson(),
};
}
static EJsonValue _toEJson(SocialSourceLocal value) => value.toEJson();
static SocialSourceLocal _fromEJson(EJsonValue ejson) {
return switch (ejson) {
{
'id': EJsonValue id,
'type': EJsonValue type,
} => SocialSourceLocal(
id: fromEJson(id),
type: fromEJson(type),
),
_ => raiseInvalidEJson(ejson),
};
}
static final schema = () {
RealmObjectBase.registerFactory(SocialSourceLocal._);
register(_toEJson, _fromEJson);
return SchemaObject(ObjectType.embeddedObject, SocialSourceLocal, 'SocialSourceLocal', [
SchemaProperty('id', RealmPropertyType.string, optional: true),
SchemaProperty('type', RealmPropertyType.string, optional: true),
]);
}();

@override
SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
