import Ember from 'ember';

export default Ember.Route.extend({
  model(params){
    return this.store.findRecord('ticket', params.id);
  },
  setupController: function(controller, model) {
    controller.set('model', model);
  }
});
