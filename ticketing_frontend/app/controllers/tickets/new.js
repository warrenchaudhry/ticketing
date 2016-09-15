import Ember from 'ember';

const { service } = Ember.inject;

export default Ember.Controller.extend({
  sessionAccount: service('session-account'),
  session: service('session'),
  statuses: ['open', 'warning', 'rejected', 'closed', 'resolved'],
  priorities: ['low', 'medium', 'high'],
  usersController: Ember.inject.controller('users'),
  ticketsController: Ember.inject.controller('tickets.index'),
  accessLevel: Ember.computed.reads('ticketsController.accessLevel'),
  isAdmin: Ember.computed.reads('ticketsController.isAdmin'),
  isAgent: Ember.computed.reads('ticketsController.isAgent'),
  isCustomer: Ember.computed.reads('ticketsController.isCustomer'),
  actions: {
    addTicket() {
      let { ticketTitle, ticketDescription, ticketReporterId, ticketAssigneeId, ticketPriority } = this.getProperties('ticketTitle', 'ticketDescription', 'ticketStatus', 'ticketReporterId', 'ticketAssigneeId', 'ticketPriority');
      let record = this.get('store').createRecord('ticket', {
        title: ticketTitle,
        description: ticketDescription,
        status: 'open',
        reporterId: ticketReporterId,
        assigneeId: ticketAssigneeId,
        priority: ticketPriority
      });

      record.save()
        .then(() => this.transitionToRoute('tickets.show', record))
        .catch(alert);
    }
  }
});
