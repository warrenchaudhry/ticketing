import Ember from 'ember';

export default Ember.Route.extend({
  afterModel(model) {
    model.rollbackAttributes();
  },
  model(params){
    return this.store.findRecord('ticket', params.id);
  }
});
