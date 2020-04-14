import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';
import '../tools/helper.dart';
import 'view.list.dart';

part 'ORMconfiguration.g.dart';
part 'ORMconfiguration.g.view.dart';

const phone = SqfEntityTable(
    tableName: 'Phones',
    primaryKeyName: 'id',
    primaryKeyType: PrimaryKeyType.integer_auto_incremental,
    useSoftDeleting: false,
    modelName: null,
    fields: [
        SqfEntityField('producer', DbType.text),
        SqfEntityField('phoneModel', DbType.text),
        SqfEntityField('androidVersion', DbType.real),
        SqfEntityField('phoneWebPage', DbType.text)
    ]
);


const seqIdentity = SqfEntitySequence(
    sequenceName: 'identity',
);

@SqfEntityBuilder(myDbModel)
const myDbModel = SqfEntityModel(
    databaseName: 'phoneapp.db',
    databaseTables: [phone],
    formTables: [phone],
    sequences: [seqIdentity],
    bundledDatabasePath: null
);
