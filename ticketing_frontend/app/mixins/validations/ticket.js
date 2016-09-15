import Ember from 'ember';
import EmberValidations from 'ember-validations';

export default Ember.Mixin.create(EmberValidations, {

  validations : {
    'model.title': {
      presence: true
    },
    'model.description': {
      presence: true
    }
  }
});
