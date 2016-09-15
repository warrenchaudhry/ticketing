import Ember from 'ember';

// const { service } = Ember.inject;

export default Ember.Controller.extend({
  ticketsController: Ember.inject.controller('tickets.index'),
  ticketStatus: Ember.computed.alias("model.status"),
  isResolved: function(){
    return this.get('ticketStatus') === 'resolved';
  }.property('ticketStatus'),
  isClosed: function(){
    return this.get('ticketStatus') === 'closed';
  }.property('ticketStatus'),
  isOpen: function(){
    return this.get('ticketStatus') === 'open';
  }.property('ticketStatus'),

  actions:{
    // update status of a ticket
    updateTicketStatus(id, status) {
      var self = this;
      var changeStatus = true;
      var reporterId = this.get('model.reporter').get('id');
      var assigneeId = this.get('model.assignee').get('id');
      var assignorId = this.get('model.assignor').get('id');

      // get the ticket
      this.store.findRecord('ticket', id).then(function(ticket) {

        // update the ticket
        ticket.set('status', status);
        ticket.set('changeStatus', changeStatus);
        ticket.set('reporterId', reporterId);
        ticket.set('assigneeId', assigneeId);
        ticket.set('assigneeId', assignorId);


        // save on the server
        ticket.save().then(() => {

          // redirect to details page
          self.set('errorMessage', null);
          self.transitionToRoute('tickets.show', ticket);
        }, (reason)=> {

          // alert('Validation failed on server. Please try again.');
          self.set('errorMessage', reason.errors || reason);
          console.log(reason.errors);
          self.model.rollbackAttributes();


        });

      });

    }
  }


});
