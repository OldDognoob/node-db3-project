//import database config
const db = require("../data/db-config");

//DB helpers
function find() {
  return db("schemes");
}
function findById(id) {
  return "schemes".where("id", id).first();
}
function findSteps(id) {
  return db("schemes as s")
    .join("steps as st", "s.id", "st.scheme_id")
    .select("s.scheme_name", "st.step_number", "st.instructions")
    .where({ "s.id": id })
    .orderBy("step_number", "asc");
}
function add(scheme) {
  return db("schemes")
    .insert(scheme)
    .then(ids => {
      return findById(ids[0]);
    });
}
function update(changes, id) {
  return db("schemes")
    .update(changes)
    .where({ id });
}
function remove(id) {
  return db("schemes")
    .where("id", id)
    .del();
}
//This method expects a step object and a scheme id. It inserts the new step into the database, correctly linking it to the intended scheme.
//addStep(step, scheme_id)
function addStep({ instructions, step_number }, scheme_id) {
  return db("steps").insert({ instructions, step_number, scheme_id });
}
//stretch goal addStep(step, scheme_id)
module.exports = { find, findById, findSteps, add, update, remove, addStep };
