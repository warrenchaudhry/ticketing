import Ember from 'ember';
import AjaxService from 'ember-ajax/services/ajax';

export default AjaxService.extend({
  session: Ember.inject.service(),
  host: 'http://localhost:3000/api/v1',
  headers: Ember.computed('session.data.authenticated.data.attributes.auth-token', {
    get() {
      let headers = {};
      const authToken = this.get('session.data.authenticated.data.attributes.auth-token');
      if (authToken) {
        headers['Authorization'] = authToken;
      }
      return headers;
    }
  })
});
