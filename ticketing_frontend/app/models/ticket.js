import DS from 'ember-data';
import { belongsTo } from 'ember-data/relationships';

export default DS.Model.extend({
  title: DS.attr('string'),
  description: DS.attr('string'),
  status: DS.attr('string'),
  priority: DS.attr('string'),
  startedAt: DS.attr('date'),
  resolvedAt: DS.attr('date'),
  reporterId: DS.attr('number'),
  assigneeId: DS.attr('number'),
  assignorId: DS.attr('number'),
  changeStatus: DS.attr('boolean'),
  reporter: belongsTo('reporter', { async: true }),
  assignee: DS.belongsTo('assignee', { async: true }),
  assignor: DS.belongsTo('assignor', { async: true })

});
