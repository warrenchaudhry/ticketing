import Ember from 'ember';

export default Ember.Route.extend({
  model(){
    return this.store.findAll('ticket');
  }
  // model(params) {
  //   return this.store.query('ticket', { page: {
  //       number: params.page,
  //       size: params.size
  //     }
  //   });
  // },
  // queryParams: {
  //   page: {
  //     refreshModel: true
  //   },
  //   size: {
  //     refreshModel: true
  //   }
  // }

});
