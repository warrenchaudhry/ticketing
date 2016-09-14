import Ember from 'ember';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

const { service } = Ember.inject;

export default Ember.Route.extend(ApplicationRouteMixin, {
  session: service('session'),
  // sessionAccount: service('session-account'),

  // renderTemplate() {
  //   var isCustomer, isManager, isAdmin;
  //   var role = this.get('sessionAccount').get('account').get('role');
  //   if (role) {
  //
  //     isCustomer = role === 'customer';
  //     isManager = role === 'agent';
  //     isAdmin   = role === 'admin';
  //   }
  //
  //   this.render();
  //
  //   if(isCustomer) {
  //     this.render("tickets");
  //   }
  //
  //   if(isManager) {
  //     this.render("about");
  //   }
  //
  //   if(isAdmin) {
  //     this.transitionTo('about');
  //   }
  //
  // }

});
