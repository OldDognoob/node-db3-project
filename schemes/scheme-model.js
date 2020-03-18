//import database config
const db = require("../data/db-config");

//DB helpers
function find() {
  return db("schemes");
}
function findById(id) {
  return db
    .select("*")
    .from("schemes")
    .where({ id })
    .first();
}
function findSteps(schemeId) {
  return db("steps")
    .select(
      "steps.id",
      "schemes.scheme_name",
      "steps.step_number",
      "steps.instructions"
    )
    .join("schemes", "schemes.id", "steps.scheme_id")
    .where("scheme_id", schemeId);
}
function add(scheme) {
  return db("schemes")
    .insert(scheme)
    .then(ids => {
      const [id] = ids;
      return findById(id[0]);
    });
}
function update(scheme_name, id) {
  return db("schemes")
    .where({ id })
    .update(scheme_name);
}
function remove(id) {
  return db("schemes")
    .where({ id })
    .del();
}
//This method expects a step object and a scheme id. It inserts the new step into the database, correctly linking it to the intended scheme.
//addStep(step, scheme_id)
// function addStep(step) {
//   return db("steps")
//     .insert(step)
//     .then(ids => ({ id: ids[0] }));
// }
//stretch goal addStep(step, scheme_id)
module.exports = { find, findById, findSteps, add, update, remove,};
