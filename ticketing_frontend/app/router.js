import Ember from 'ember';
import config from './config/environment';
import ApplicationRouteMixin from 'ember-simple-auth/mixins/application-route-mixin';

const Router = Ember.Router.extend(ApplicationRouteMixin, {
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('users', function() {
    this.route('user', { path: '/:user_id' });
  });
  this.route('about');
  this.route('login');
  this.route('tickets', function(){
    this.route('new', { path: '/new' });
    this.route('show', { path: '/:id' });
  });
  

  this.route('dashboard');
});

export default Router;
