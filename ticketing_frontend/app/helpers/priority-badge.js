import Ember from 'ember';

export function priorityBadge(params) {
  var priority = params[0];
  var icon;
  if (priority === 'low'){
    icon = 'fa-long-arrow-down';
  }else if (priority === 'medium'){
    icon = 'fa-arrows-h';
  }else{
    icon = 'fa-long-arrow-up';
  }
  return Ember.String.htmlSafe(`<i class="fa ${icon} fa-lg" aria-hidden="true"></i>`);
}

export default Ember.Helper.helper(priorityBadge);
