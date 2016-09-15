import Ember from 'ember';
const { service } = Ember.inject;

export default Ember.Controller.extend({
  init: function() {
    this._super();
    this.setRole();
  },
  sessionAccount: service('session-account'),
  session: service('session'),

  isAdmin: false,
  isAgent: false,
  isCustomer: false,
  accessLevel:  Ember.computed(function(){
    return this.get('sessionAccount').get('account').get('role');
  }),
  // queryParams: ['page', 'size'],
  // page: 1,
  // size: 20,
  // count: Ember.computed('model.meta.pagination.last.number', 'model.meta.pagination.self.number', function() {
  //   const total = this.get('model.meta.pagination.last.number') || this.get('model.meta.pagination.self.number');
  //   if (!total){
  //     return [];
  //   }
  //   return new Array(total+1).join('x').split('').map((e,i) => i+1);
  // }),
  setRole: function(){
    var role = this.get('accessLevel');
    if (role === 'admin'){
      this.set('isAdmin', true);
    }else if (role === 'agent'){
      this.set('isAgent', true);
    }else{
      this.set('isCustomer', true);
    }
  },
  pageHeader : function(){
    var role = this.get('accessLevel');
    if (role ==='admin'){
      return "Current Tickets";
    }else if (role === 'agent') {
      return "Assigned and Open Tickets";
    }else{
      return "My Tickets";
    }
  }.property('accessLevel')

});
