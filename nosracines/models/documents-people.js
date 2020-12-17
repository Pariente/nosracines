// This model was generated by Lumber. However, you remain in control of your models.
// Learn how here: https://docs.forestadmin.com/documentation/v/v6/reference-guide/models/enrich-your-models
module.exports = (sequelize, DataTypes) => {
  const { Sequelize } = sequelize;
  // This section contains the fields of your model, mapped to your table's columns.
  // Learn more here: https://docs.forestadmin.com/documentation/v/v6/reference-guide/models/enrich-your-models#declaring-a-new-field-in-a-model
  const DocumentsPeople = sequelize.define('documentsPeople', {
    createdAt: {
      type: DataTypes.DATE,
    },
    updatedAt: {
      type: DataTypes.DATE,
    },
  }, {
    tableName: 'documents_people',
    underscored: true,
    schema: process.env.DATABASE_SCHEMA,
  });

  // This section contains the relationships for this model. See: https://docs.forestadmin.com/documentation/v/v6/reference-guide/relationships#adding-relationships.
  DocumentsPeople.associate = (models) => {
    DocumentsPeople.belongsTo(models.documents, {
      foreignKey: {
        name: 'documentIdKey',
        field: 'document_id',
      },
      as: 'document',
    });
    DocumentsPeople.belongsTo(models.people, {
      foreignKey: {
        name: 'personIdKey',
        field: 'person_id',
      },
      as: 'person',
    });
  };

  return DocumentsPeople;
};
