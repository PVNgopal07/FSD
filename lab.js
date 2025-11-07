const mongoose = require("mongoose");

const url = "mongodb+srv://ManOnFire:ManOnFire%4007@manonfire.la32hn6.mongodb.net/schoolDB?retryWrites=true&w=majority&appName=ManOnFire";

const StudentSchema = new mongoose.Schema({
  Name: String,
  Roll: Number,
  Marks: Number,
});

const Student = mongoose.model("Student", StudentSchema);

async function Crud() {
  try {
    await mongoose.connect(url);
    console.log("MongoDB connected to:", mongoose.connection.name);

    const newStudent = await Student.create({
      Name: "VenuGopal",
      Roll: 25,
      Marks: 100
    });
    console.log("Inserted:", newStudent);

    await Student.insertMany([
      { Name: "Sharoo", Roll: 26, Marks: 95 },
      { Name: "Rahul", Roll: 27, Marks: 88 },
      { Name: "Anjali", Roll: 28, Marks: 91 }
    ]);
    console.log("Multiple students inserted!");

    const all = await Student.find({});
    console.log("All Students:", all);

    const deleteResult = await Student.deleteOne({ Name: "Anjali" });
    console.log("Delete Result:", deleteResult);

    const afterDelete = await Student.find({});
    console.log("After Deleting Anjali:", afterDelete);

  } catch (err) {
    console.error(err);
  } finally {
    mongoose.connection.close();
  }
}

Crud();
