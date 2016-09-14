import { moduleForModel, test } from 'ember-qunit';

moduleForModel('ticket', 'Unit | Model | ticket', {
  // Specify the other units that are required for this test.
  needs: ['model:reporter', 'model:assignee', 'model:assignor']
});

test('it exists', function(assert) {
  let model = this.subject();
  // let store = this.store();
  assert.ok(!!model);
});
