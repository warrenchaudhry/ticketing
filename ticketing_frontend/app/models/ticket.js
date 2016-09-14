import DS from 'ember-data';

export default DS.Model.extend({
  title: DS.attr('string'),
  description: DS.attr('string'),
  status: DS.attr('string'),
  priority: DS.attr('string'),
  startedAt: DS.attr('date'),
  resolvedAt: DS.attr('date'),
  reporter: DS.belongsTo('reporter', { async: true }),
  assignee: DS.belongsTo('assignee', { async: true }),
  assignor: DS.belongsTo('assignor', { async: true })

});
