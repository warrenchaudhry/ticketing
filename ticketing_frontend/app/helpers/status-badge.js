import Ember from 'ember';

export function statusBadge(params) {
  var span_class;
  var status = params[0];
  if (status === 'open'){
    span_class = 'info';
  }else if (status === 'rejected'){
    span_class = 'danger';
  }else if (status === 'working'){
    span_class = 'warning';
  }else if (status === 'resolved'){
    span_class = 'success';
  }else{
    span_class = 'primary';
  }
  return Ember.String.htmlSafe(`<span class="label label-${span_class}">${status.toUpperCase()}</span>`);
}

export default Ember.Helper.helper(statusBadge);
