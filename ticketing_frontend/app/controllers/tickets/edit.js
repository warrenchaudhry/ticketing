import Ember from 'ember';
import RequestValidations from 'ticketing-frontend/mixins/validations/ticket';

export default Ember.Controller.extend(RequestValidations, {
  ticketsController: Ember.inject.controller('tickets.new'),
  usersController: Ember.inject.controller('users'),
  actions : {

    updateTicket(id) {
      var self = this;

      var title = this.get('model.title');
      var description = this.get('model.description');
      var status = this.get('model.status');
      var priority = this.get('model.priority');
      var reporter_id = this.get('model.reporter_id');
      var assignee_id = this.get('model.assignee_id');

      this.validate().then(() => {
        // get the ticket
        this.store.findRecord('ticket', id).then(function(ticket) {

          // update the ticket
          ticket.set('title', title);
          ticket.set('description', description);
          ticket.set('status', status);
          ticket.set('priority', priority);
          ticket.set('reporterId', reporter_id);
          ticket.set('assigneeId', assignee_id);

          // save on the server
          ticket.save().then(() => {
            // clear fields
            self.setProperties({title: '', description: '', status: '', priority: '', reporter_id: '', assignee_id: ''});

            // redirect to details page
            self.transitionToRoute('tickets.show', ticket);
          }, (reason)=> {

            // alert('Validation failed on server. Please try again.');
            self.set('errorMessage', reason.errors || reason);
            console.log(reason.errors);
            self.model.rollbackAttributes();


          });

        });

      }, () => {

        alert('Validation failed on client side. Please try again.');
        self.model.rollbackAttributes();


      }).catch(() => {

        console.log('exception in tickets : edit : updateTicket ');

      });
    }

  }

});
