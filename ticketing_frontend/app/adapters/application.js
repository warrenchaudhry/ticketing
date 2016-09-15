import DS from 'ember-data';
import DataAdapterMixin from 'ember-simple-auth/mixins/data-adapter-mixin';
import Ember from 'ember';
import config from '../config/environment';


export default DS.JSONAPIAdapter.extend(DataAdapterMixin, {
  session: Ember.inject.service('session'),
  namespace: config.apiNamespace,
  host: config.apiHost,

  headers: Ember.computed(function() {
    // console.log(this.get('session.data.authenticated.data.attributes.auth-token'));
    var token = this.get('session.data.authenticated.token');
    // var token = 'EL-oSzY6sxv4v1v5xsy2';
    return { 'Authorization' : token, 'Access-Control-Allow-Origin' : '*' };
  }).volatile(),

  authorizer: 'authorizer:devise',
  shouldReloadAll() { return true; },

  shouldReloadRecord() { return true; }

});
