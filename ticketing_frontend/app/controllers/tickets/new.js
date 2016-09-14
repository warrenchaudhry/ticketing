import Ember from 'ember';

export default Ember.Controller.extend({
  statuses: ['open', 'pending', 'rejected', 'closed'],
  actions: {
    addTicket() {
      let { ticketTitle, ticketDescription } = this.getProperties('ticketTitle', 'ticketDescription');
      let record = this.get('store').createRecord('ticket', {
        title: ticketTitle,
        description: ticketDescription
      });

      record.save()
        .then(() => this.transitionToRoute('tickets.show', record))
        .catch(alert);
    }
  }
});
