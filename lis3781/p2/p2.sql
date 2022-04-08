//1. dispaly documents in collection
db.restaurants.find();

//1b. one document that statifies
db.restaurants.findOne();

//2. num documents in collection
db.restaurants.find().count()
//3. retrive 1st 5 documents
db.restaurants.find().limit(5);
//4. retrieve restaurants in the brooklyn borough
db.restaurants.find({"borough":" Brooklyn "})
//OR
db.restaurants.find({"borough": /^brooklyn$/i})
// 5. Retrieve restaurants whose cuisine is American, (cmd+c to make it not mad)
db.restaurants.find({"cuisine": "American"})

// 6. Retrieve restaurants whose borough is Manhattan and cuisine is hamburgers.
db.restaurants.find({ "borough": Manhattan}, "cuisine": hamburgers})
// OR
db.restaurants.find({ "borough": Manhattan}, "cuisine": hamburgers}, {"name": 1, "restaurant_id" :1 })

// 7. Display the number of restaurants whose borough is Manhattan and cuisine is hamburgers.
db.restaurants.find({ "borough": Manhattan}, "cuisine": hamburgers}).count()

// 8. Query zipcode field in embedded address document and Retrieve restaurants in the 10075 zip code area.
db.restaurants.find({"address.zipcode": "10075"})

// 9. Retrieve restaurants whose cuisine is chicken and zip code is 10024.
db.restaurants.find({"cuisine": "chicken "}, {"address.zipcode": "10024"})
// OR
db.restaurants.find({$and: [{"cuisine": "chicken "}, {"address.zipcode": "10024"}]})

// 10. Retrieve restaurants whose cuisine is chicken or whose zip code is 10024
db.restaurants.find({$or: [{"cuisine": "chicken "}, {"address.zipcode": "10024"}]})

// 11. Retrieve restaurants whose borough is Queens, cuisine is Jewish/kosher, sort by descending order of zipcode.
db.restaurants.find({"borough": "Queens", "cuisine": "Jewish/kosher"}.sort({"address.zipcode": -1})

// 12. Retrieve restaurants with a grade A.
db.restaurants.find({"grades.grade":"A"}).limit(1).pretty()

// 13. Retrieve restaurants with a grade A, displaying only collection id, restaurant name, and grade.
db.restaurants.find({"grades.grade":"A"}, {"name": 1, "grades.grade":1}).count()

// 14. Retrieve restaurants with a grade A, displaying only restaurant name, and grade (no collection id):
db.restaurants.find({"grades.grade":"A"}, {"name": 1, "grades.grade":1, _id:0 }).count()

// 15. Retrieve restaurants with a grade A, sort by cuisine ascending, and zip code descending.
db.restaurants.find({"grades.grade":"A"}).sort({"cuisine":1, "address.zipcode": -1})

// 16. Retrieve restaurants with a score higher than 80.
db.restaurants.find({"grades.score":{$gt: 80}})

//17. Inserting Date

db.restaurants.insert(

{

"address":{
"street": "7th Avenue",
"zipcode": "10024",
"building": "1000",
"coord" : [-58.9557413, 31.7720266 ],
},
"borough" :"Brooklyn:,
"cuisine" : "BBQ",
grades":[
{
"date" : ISODate("2015-11-05T00:00:00Z"),
grade" : "C",
"score" : 15,
}
],
"name": "Big Tex",
"restaurant_id" : "61704627" }
)

//18. Updating
db.restaurants.find({"name": "White Castle"},{_id:1}).limit(1)

db.restaurants.update(
  {"_id" : ObjectID(...)},
   {
   $set:{ "cuisine": "Steak and Sea Food"}, $currentDate: {"lastModified": true}
   }
   )

//19. Deleting
db.restaurants.remove({ "name": "White Castle" })
)
