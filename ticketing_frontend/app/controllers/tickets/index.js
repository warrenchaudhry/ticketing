import Ember from 'ember';
const { service } = Ember.inject;

export default Ember.Controller.extend({
  sessionAccount: service('session-account'),
  session: service('session'),

  accessLevel:  Ember.computed(function(){
    return this.get('sessionAccount').get('account').get('role');
  })

});
