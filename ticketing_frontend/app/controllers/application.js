import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({

  session: service('session'),
  sessionAccount: service('session-account'),
  init: function() {
    this._super();
    this.setRole();
  },
  isAdmin: false,

  accessLevel: Ember.computed(function(){
    var loggedIn = this.get('session').get('isAuthenticated');
    if(loggedIn){
      return this.get('sessionAccount').get('account').get('role');
    }else{
      return null;
    }

  }),
  setRole: function(){
    var role = this.get('accessLevel');
    if (role === 'admin'){
      this.set('isAdmin', true);
    }
  },
  actions: {
    invalidateSession() {
      this.get('session').invalidate();
    }
  }

});
