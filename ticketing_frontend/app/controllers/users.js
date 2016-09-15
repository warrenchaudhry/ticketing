import Ember from 'ember';

export default Ember.Controller.extend({

  allUsers: Ember.computed(function(){
   return this.store.findAll('user');
  }),

  allAgents: Ember.computed(function(){
    return this.store.query('user', { filter: { role: 'agent' } });
  }),
  allCustomers: Ember.computed(function(){
    return this.store.query('user', { filter: { role: 'customer' } });
  }),
});
